from rest_framework import serializers

from .models import User


class loginSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("email", "password")

class registerSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"
