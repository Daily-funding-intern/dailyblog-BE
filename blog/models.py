from django.db import models

class Category(models.Model):
    name=models.CharField(max_length=100)
    
    def __str__(self):
        return self.name

class Post(models.Model):
    title=models.CharField(max_length=100)
    subtitle=models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    content=models.TextField()
    description=models.TextField(max_length=255, blank=True)
    thumbnail=models.CharField(max_length=255)
    category=models.ForeignKey(Category, on_delete=models.CASCADE)
    is_featured = models.BooleanField(default=False) #블로그 초기 화면 슬라이스 표시 필드
    visit_count = models.IntegerField(default=0) # 방문수 확인 컬럼
      
    def __str__(self):
        return self.title