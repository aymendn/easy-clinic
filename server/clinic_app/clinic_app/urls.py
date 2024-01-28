
from django.contrib import admin
from django.urls import path , include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/accounts/",include("accounts.urls")),
    path("api/comments/",include("comment.urls")),
    path("api/appointments/",include("appointments.urls"))
    ]

