from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from blog.models import Post
from blog.serializer import PostListSerializer,PostThumbnailSerializer,PostDetailSerializer, PostRecommendSerializer
from blog.serializer import PostCreateSerializer, PostUpdateSerializer, PostAdminListSerializer, UploadSerializer
from blog.utils.s3 import upload_file_to_s3_tmp, delete_images_from_s3, delete_thumbnail_from_s3
from rest_framework.permissions import IsAdminUser, AllowAny
from rest_framework.views import APIView
from django.db.models import F

from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.parsers import MultiPartParser, FormParser

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
    
    @swagger_auto_schema(
        operation_summary="게시글 목록 조회",
        operation_description="게시글 목록 조회 (일반 사용자는 featured 게시글만 조회 가능, 관리자는 전체 조회 가능)",
        manual_parameters=[
            openapi.Parameter(
                'category_id',
                openapi.IN_QUERY,
                description="카테고리 ID (선택)",
                type=openapi.TYPE_INTEGER
            ),
            openapi.Parameter(
                'page',
                openapi.IN_QUERY,
                description="페이지 번호 (선택)",
                type=openapi.TYPE_INTEGER
            )
        ],
        responses={200: PostListSerializer(many=True)}
    )
    def list(self, request, *args, **kwargs):
        return super().list(request,*args, **kwargs)
    
    @swagger_auto_schema(
        operation_summary="게시글 상세 조회",
        operation_description="게시글 상세 조회 (일반 사용자는 조회수 증가)",
        responses={200: PostDetailSerializer}
    )
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        if not request.user.is_staff:
            Post.objects.filter(pk=instance.pk).update(
                visit_count=F('visit_count') + 1
            )
            instance.refresh_from_db()

        serializer = self.get_serializer(instance)
        return Response(serializer.data)
    
    @swagger_auto_schema(
        operation_summary="게시글 생성(관리자)",
        request_body=PostCreateSerializer,
        responses={201:PostDetailSerializer}
    )
    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)
    
    @swagger_auto_schema(
        operation_summary="게시글 부분 수정 (관리자)",
        request_body=PostUpdateSerializer,
        responses={200: PostDetailSerializer}
    )
    def partial_update(self, request, *args, **kwargs):
        return super().partial_update(request, *args, **kwargs)
    
    @swagger_auto_schema(
        operation_summary="게시글 삭제",
        operation_description="게시글 삭제 (관리자)",
        responses={204:"No Content"}
    )
    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)
    
    @swagger_auto_schema(
    method="get",
    operation_summary="캐러셀 확인",
    operation_description="캐러셀 확인용 API",
    responses={200: PostThumbnailSerializer(many=True)},
)
    @action(
        detail=False,
        methods=["get"],
        pagination_class=None
    )
    def featured(self, request):
        queryset = super().get_queryset().filter(is_featured=True)[:15]
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    @swagger_auto_schema(
        method ='get',
        operation_summary="추천 게시글(또 다른 인사이트 전용)",
        manual_parameters=[
            openapi.Parameter(
                'category_id',
                openapi.IN_QUERY,
                description="카테고리 ID",
                type = openapi.TYPE_INTEGER
            )
        ],
        responses={200 : PostRecommendSerializer(many=True)}
    )
    @action(detail=False, methods=['get'], pagination_class=None) 
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
    parser_classes = [MultiPartParser, FormParser]
    
    @swagger_auto_schema(
        operation_summary="사진 업로드",
        operation_description="사진 업로드 시 url 반환",
        request_body=UploadSerializer,
    )
    def post(self, request):
        file = request.FILES.get("file")
        if not file:
            return Response({"error": "파일이 존재하지 않습니다."}, status=400)
        file_url = upload_file_to_s3_tmp(file)
        return Response({"file_url": file_url})