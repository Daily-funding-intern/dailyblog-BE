from rest_framework import viewsets
from blog.models import Category
from blog.serializer import CategorySerializer

class CategoryViewSet(viewsets.ModelViewSet): #카테고리 정보 가져오는 api
    queryset=Category.objects.all()
    serializer_class=CategorySerializer
    pagination_class = None