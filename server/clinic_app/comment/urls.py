from django.urls import path
from .views import getComments, postComment

urlpatterns = [
    path('create/', postComment, name='comment'),
    path('get/', getComments, name='comments'),
]