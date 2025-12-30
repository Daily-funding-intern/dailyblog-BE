from rest_framework import viewsets,mixins
from rest_framework.decorators import action
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from django.http import JsonResponse
import uuid
from blog.models import Post
from blog.serializer import PostListSerializer,PostThumbnailSerializer,PostDetailSerializer, PostRecommendSerializer, PostCreateSerializer
from blog.utils.s3 import upload_file_to_s3

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

class PostCreateViewSet(mixins.CreateModelMixin,
    viewsets.GenericViewSet):
    queryset = Post.objects.all()
    serializer_class = PostCreateSerializer
    

@csrf_exempt
def UploadView(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'POST만 가능'}, status=405)
    file = request.FILES.get('file')
    if not file:
        return JsonResponse({'error' : '파일이 존재하지 않습니다.'}, status=400)
    filename=f"uploads/{uuid.uuid4()}_{file.name}"
    file_url=upload_file_to_s3(file,filename)
    return JsonResponse({
        'file_url': file_url
    })