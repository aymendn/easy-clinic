from django.db import models

# Create your models here.




class User(models.Model):
    id = models.AutoField(primary_key=True)
    role = models.CharField(max_length=255)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)

    def __str__(self):
        return self.email
