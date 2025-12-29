from django.urls import path,include
from blog.views import CategoryViewSet,PostViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'category', CategoryViewSet)
router.register(r'post',PostViewSet)
urlpatterns = [
    path('',include(router.urls))
]
