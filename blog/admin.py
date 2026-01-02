from blog.models import Post, Category
from blog.admin_site import admin_site

admin_site.register(Post)
admin_site.register(Category)
