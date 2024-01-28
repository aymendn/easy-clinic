from django.urls import path
from .views import book_appointment, update_request_status, add_file, update_appointment_status

urlpatterns = [
    path('book-appointment/', book_appointment, name='book-appointment'),
    path('update-request-status/<int:request_id>/', update_request_status, name='update-request-status'),
    path('add-file/', add_file, name='add-file'),
    path('update-appointment-status/<int:appointment_id>/', update_appointment_status, name='update-appointment-status'),
]
