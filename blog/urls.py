from django.urls import path,include
from blog.views import CategoryViewSet,PostViewSet, UploadView, PostCreateViewSet, MeView
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'category', CategoryViewSet)
router.register(r'post',PostViewSet)
router.register(
    r'post-create',
    PostCreateViewSet,
    basename='post-create'
)

urlpatterns = [
    path('',include(router.urls)),
    path('uploadfile/', UploadView),
    path('check-auth/',MeView.as_view()),
]
