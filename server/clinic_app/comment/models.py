from django.db import models

# Create your models here.

class Comment(models.Model):
    content = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    rating = models.IntegerField()

    def __str__(self):
        return self.content
