from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from blog.models import Post
from blog.serializer import PostListSerializer,PostThumbnailSerializer,PostDetailSerializer, PostRecommendSerializer

class PostViewSet(viewsets.ModelViewSet):
    queryset=Post.objects.all()
    def get_serializer_class(self):
        if self.action == 'featured':
            return PostThumbnailSerializer
        elif self.action == 'list':
            return PostListSerializer
        elif self.action == 'retrieve':
            return PostDetailSerializer
        return PostListSerializer
    
    def get_queryset(self):
        queryset = Post.objects.all().order_by('-created_at')
        category_id = self.request.query_params.get('category_id')
        if category_id:
            queryset = queryset.filter(category_id=category_id)
        return queryset
        
    @action(detail=False, methods=['get'])
    def featured(self, request):
        queryset = self.get_queryset().filter(is_featured=True)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def recommend(self, request):
        category_id = request.query_params.get('category_id')
        queryset = self.get_queryset().order_by('-created_at')
        if category_id:
            queryset = queryset.filter(category_id=category_id)
        queryset = queryset[:6]
        serializer = PostRecommendSerializer(queryset, many=True)
        return Response(serializer.data)