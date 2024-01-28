from django.contrib import admin
from .models import Patient, Request, Appointment, File

admin.site.register(Patient)
admin.site.register(Request)
admin.site.register(Appointment)
admin.site.register(File)
