from django.http import JsonResponse
from django.shortcuts import render
from django.db import connections
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .serializers import registerSerializer,loginSerializer
# Create your views here.


@api_view(['POST'])
def login(request):
    serializer = loginSerializer(data=request.data)
    email = request.data["email"],
    password = request.data["password"],
    connection = connections['default']
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM accounts_user WHERE email = %s AND password = %s", [email,password])
            user = cursor.fetchone()
            if user and serializer.is_valid():
                validated_data = serializer.validated_data
                return Response(validated_data)
            else:
                return Response({"message": "Invalid credentials", "errors": serializer.errors}, status=400)
    except:
        return Response({"message":"Error occurred while logging in"}, status=405)



@api_view(['POST'])
def logout(request):
    email = request.data["email"]
    connection = connections['default']
    with connection.cursor() as cursor:
        cursor.execute("DELETE FROM accounts_user WHERE email = %s", [email])

        if cursor.rowcount == 0:
            return Response({"message": "User does not exist"})
        else:
             return Response({"message": "Logout successful"})


@api_view(['POST'])
def register(request):
    serializer = registerSerializer(data=request.data)
    if serializer.is_valid():
        validated_data = serializer.validated_data
        role = validated_data["role"],
        first_name = validated_data["first_name"],
        last_name = validated_data["last_name"],
        email = validated_data["email"],
        password = validated_data["password"],
        connection = connections['default']
        try:
         with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM accounts_user WHERE email = %s", [email])
            user = cursor.fetchone()
            if user:
                return Response({"message":"user already exists"})
            else:
                 cursor.execute("INSERT INTO accounts_user (role,first_name,last_name,email,password) VALUES (%s,%s,%s,%s,%s)",
                       [role,first_name,last_name,email,password])
    
                 return Response({"message": "User registered successfully","data":validated_data})
        except:
         return Response({"message": "Error occurred while registering user"})
    else:
      return Response({"message": "Invalid credentials", "errors": serializer.errors}, status=400)
       



