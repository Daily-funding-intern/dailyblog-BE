from django.test import TestCase
from blog.models import Post,Category
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase, APIClient

class PostModelTest(APITestCase):

    def setUp(self):
        self.client = APIClient()
        self.category1 = Category.objects.create(name='testCategory1')
        self.category2 = Category.objects.create(name = 'testCategory2')
        
        self.post1 = Post.objects.create(
            title='First Post',
            subtitle='테스트1',
            content='Hello World',
            description='테스트1',
            thumbnail='www.example1.com',
            category=self.category1,
            is_featured=True
        )
        self.post2 = Post.objects.create(
            title='Second Post',
            subtitle='테스트2',
            content='More content',
            description='테스트2',
            thumbnail='www.example2.com',
            category=self.category2,
            is_featured=False
        )
        
    def test_post_list(self):
        self.list_url = reverse('post-list')
        response = self.client.get(self.list_url)
        self.assertEqual(response.status_code,status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']),2)
        titles = [post['title'] for post in response.data['results']]
        self.assertIn('First Post', titles)
        self.assertIn('Second Post', titles)
    
    def test_post_list_with_category(self):
        self.list_url = reverse('post-list')
        response = self.client.get(self.list_url, {'category_id': self.category1.id})
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['results']), 1)
        self.assertEqual(response.data['results'][0]['title'], 'First Post')