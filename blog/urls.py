from django.urls import path,include
from blog.views import CategoryListView,PostViewSet, UploadView,MeView
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'post',PostViewSet)

urlpatterns = [
    path('',include(router.urls)),
    path('uploadfile/', UploadView.as_view()),
    path('check-auth/',MeView.as_view()),
    path('category/', CategoryListView.as_view())
]
