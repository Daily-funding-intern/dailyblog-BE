from django.test import TestCase
from blog.models import Post
from django.urls import reverse
from rest_framework import status

class PostTest(TestCase):
    def setup(self):
        self.post1 = Post.objects.create(title = '제목1', subtitle = '부제목1', 
                                         content = '<Html>테스트1</Html>',
                                         description = '테스트1', thumbnail = 'www.example.com',
                                         is_featured = True)