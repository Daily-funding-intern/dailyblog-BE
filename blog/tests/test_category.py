from django.test import TestCase
from blog.models import Category
from django.urls import reverse
from rest_framework import status

class CategoryModelTest(TestCase):
    def setUp(self):
        self.category1 = Category.objects.create(name = 'test1')
        self.category2 = Category.objects.create(name = 'test2')
        self.list_url = reverse('category-list')
    
    def test_category_list(self):
        response = self.client.get(self.list_url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data), 2)
        self.assertEqual(response.data[0]['name'],'test1')
        self.assertEqual(response.data[1]['name'],'test2')
        