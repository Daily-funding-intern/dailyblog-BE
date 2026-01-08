from blog.models import Category
from blog.serializer import CategorySerializer
from rest_framework.generics import ListAPIView

from drf_yasg.utils import swagger_auto_schema

class CategoryListView(ListAPIView):  # 카테고리 전체 조회 API
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = None

    @swagger_auto_schema(
        operation_summary="카테고리 목록 조회",
        operation_description="카테고리 전체 목록을 조회합니다.",
        responses={200: CategorySerializer(many=True)}
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)