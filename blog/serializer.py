from rest_framework import serializers
from .models import Category,Post
from blog.utils.html_parsar import extract_description
from blog.utils.s3 import finalize_uploaded_images, finalize_uploaded_thumbnail

class CategorySerializer(serializers.ModelSerializer): #카테고리 전체 조회용
    class Meta:
        model=Category
        fields=['id','name']
    
class PostListSerializer(serializers.ModelSerializer): #게시글 전체 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','description','thumbnail','category','created_at']
        
class PostThumbnailSerializer(serializers.ModelSerializer): #홈화면 상단 썸네일 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','subtitle','thumbnail','is_featured','category']

class PostDetailSerializer(serializers.ModelSerializer): #글 상세보기 조회용
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','content','category','subtitle','thumbnail','is_featured']

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
        
        thumbnail = validated_data.get("thumbnail")
        validated_data["thumbnail"] = finalize_uploaded_thumbnail(thumbnail)
        
        validated_data["description"] = extract_description(content)
        return super().create(validated_data)

class PostUpdateSerializer(serializers.ModelSerializer):
    category = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all()
    )
    class Meta:
        model = Post
        fields = [
            "title",
            "subtitle",
            "content",
            "category",
            "thumbnail",
            "is_featured",
        ]
    def update(self, instance, validated_data):
        if "content" in validated_data:
            content = validated_data["content"]
            content = finalize_uploaded_images(content)
            validated_data["content"] = content
            validated_data["description"] = extract_description(content)
            
        if "thumbnail" in validated_data:
            new_thumbnail = validated_data["thumbnail"]

        # 실제로 변경된 경우만 finalize
        if new_thumbnail and new_thumbnail != instance.thumbnail:
            validated_data["thumbnail"] = finalize_uploaded_thumbnail(new_thumbnail)
        else:
            # 변경 안 됐으면 업데이트 대상에서 제거
            validated_data.pop("thumbnail")

        return super().update(instance, validated_data)
    
class PostAdminListSerializer(serializers.ModelSerializer):
    category = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all()
    )
    class Meta:
        model=Post
        fields = "__all__"