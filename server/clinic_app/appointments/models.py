from django.db import models

class Patient(models.Model):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=15)
    email = models.EmailField()
    address = models.CharField(max_length=255)
    birthday_date = models.DateField()

class Request(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    date_time = models.DateTimeField()
    patient_status = models.CharField(max_length=255)
    message = models.TextField()
    request_status = models.CharField(max_length=255)

class Appointment(models.Model):
    request = models.ForeignKey(Request, on_delete=models.CASCADE)
    information = models.CharField(max_length=255,null=True)
    status = models.CharField(max_length=255)

class File(models.Model):
    name = models.CharField(max_length=255)
    path = models.CharField(max_length=255)
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE)

