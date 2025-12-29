from rest_framework import serializers
from .models import Category,Post

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
        fields=['id','title','content','category']

class PostRecommendSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    class Meta:
        model=Post
        fields=['id','title','thumbnail','category']