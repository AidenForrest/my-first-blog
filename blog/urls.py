from xml.etree.ElementInclude import include
from django.urls import path
from . import views
from .forms import CustomLoginForm
from django.contrib import admin
from django.contrib.auth import views as authViews
from .views import (
    PostListApiView,
)

urlpatterns = [
    path('', views.post_list, name='post_list'),
    path('post/<int:pk>/', views.post_detail, name='post_detail'),
    path('post/new/', views.post_new, name='post_new'),
    path('post/<int:pk>/edit/', views.post_edit, name='post_edit'),
    path('drafts/', views.post_draft_list, name='post_draft_list'),
    path('post/<int:pk>/publish/', views.post_publish, name='post_publish'),
    path('post/<int:pk>/delete/', views.post_delete, name='post_delete'),
    path('accounts/login/', authViews.LoginView.as_view(authentication_form=CustomLoginForm), name='login'),
    path('accounts/logout/', authViews.LogoutView.as_view(next_page='/'), name='logout'),
    path('post/<int:pk>/comment/', views.add_comment_to_post, name='add_comment_to_post'),
    path('post/<int:pk>/approve/', views.approve, name='approve'),
    path('post/<int:pk>/comment/delete', views.delete_comment, name='delete_comment'),
    path('post/api', PostListApiView.as_view())
]