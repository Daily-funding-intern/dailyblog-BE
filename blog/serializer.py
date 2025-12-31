from rest_framework import serializers
from .models import Category,Post
from blog.utils.html_parsar import extract_description
from blog.utils.s3 import finalize_uploaded_images

class CategorySerializer(serializers.ModelSerializer): #카테고리 전체 조회용
    class Meta:
        model=Category
        fields=['id','name']
    
class PostListSerializer(serializers.ModelSerializer): #게시글 전체 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','description','thumbnail','category']
        
class PostThumbnailSerializer(serializers.ModelSerializer): #홈화면 상단 썸네일 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','subtitle','thumbnail','is_featured','category']

class PostDetailSerializer(serializers.ModelSerializer): #글 상세보기 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','content','category','subtitle','thumbnail']

class PostRecommendSerializer(serializers.ModelSerializer): #글 추천 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','thumbnail','category']
        
class PostCreateSerializer(serializers.ModelSerializer): # 글 생성 post
    category = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all()
    )
    class Meta:
        model = Post
        fields = [
            'title',
            'subtitle',
            'content',
            'thumbnail',
            'category',
            'is_featured',
        ]
    def create(self, validated_data): #save 실행 시, 호출됨
        content = validated_data.get("content", "")
        content = finalize_uploaded_images(content)
        validated_data["content"] = content
        validated_data["description"] = extract_description(content)
        return super().create(validated_data)
