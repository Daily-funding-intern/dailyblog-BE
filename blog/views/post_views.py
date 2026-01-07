from rest_framework import viewsets,mixins
from rest_framework.decorators import action
from rest_framework.response import Response
from blog.models import Post
from blog.serializer import PostListSerializer,PostThumbnailSerializer,PostDetailSerializer, PostRecommendSerializer
from blog.serializer import PostCreateSerializer, PostUpdateSerializer, PostAdminListSerializer
from blog.utils.s3 import upload_file_to_s3_tmp, delete_images_from_s3, delete_thumbnail_from_s3
from rest_framework.permissions import IsAdminUser, AllowAny
from rest_framework.views import APIView
from django.db.models import F

class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all().select_related('category','user').order_by('-id')
    def get_serializer_class(self):
        if self.action == 'featured':
            return PostThumbnailSerializer
        elif self.action == 'list' and not self.request.user.is_staff:
            return PostListSerializer
        elif self.action == 'list' and self.request.user.is_staff:
            return PostAdminListSerializer
        elif self.action == 'retrieve':
            return PostDetailSerializer
        elif self.action in ["update", "partial_update"]:
            return PostUpdateSerializer
        elif self.action == 'create':
            return PostCreateSerializer
        return PostListSerializer
    
    def get_permissions(self):
        if self.action in ["create", "update", "partial_update", "destroy"]:
            return [IsAdminUser()]
        return [AllowAny()]
    
    def get_queryset(self):
    # 일반 사용자만 featured 필터
        queryset = super().get_queryset()
        if not self.request.user.is_staff:
            queryset = queryset.filter(is_featured=True)

        category_id = self.request.query_params.get('category_id')
        if category_id:
            queryset = queryset.filter(category_id=category_id)

        return queryset
    
    def get_serializer_context(self):
        context = super().get_serializer_context()
        context['request'] = self.request
        return context
    
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        if not request.user.is_staff:
            Post.objects.filter(pk=instance.pk).update(
                visit_count=F('visit_count') + 1
            )
            instance.refresh_from_db()

        serializer = self.get_serializer(instance)
        return Response(serializer.data)
    
    @action(detail=False, methods=["get"])
    def featured(self, request):
        queryset = super().get_queryset().filter(is_featured=True)[:15]
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def recommend(self, request):
        category_id = request.query_params.get('category_id')
        queryset = self.get_queryset()
        if category_id:
            queryset = queryset.filter(category_id=category_id)
        queryset = queryset[:6]
        serializer = PostRecommendSerializer(queryset, many=True)
        return Response(serializer.data)
    
    def perform_destroy(self, instance):
        delete_images_from_s3(instance.content)
        delete_thumbnail_from_s3(instance.thumbnail)
        instance.delete()

    

class UploadView(APIView):
    permission_classes = [IsAdminUser]
    def post(self, request):
        file = request.FILES.get("file")
        if not file:
            return Response({"error": "파일이 존재하지 않습니다."}, status=400)
        file_url = upload_file_to_s3_tmp(file)
        return Response({"file_url": file_url})