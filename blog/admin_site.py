from django.contrib import admin
from django.shortcuts import redirect

class MyAdminSite(admin.AdminSite):
    def login(self, request, extra_context=None):
        response = super().login(request, extra_context)
        if request.user.is_authenticated:
            return redirect('http://127.0.0.1:3000/admin/post')
        return response

admin_site = MyAdminSite()
