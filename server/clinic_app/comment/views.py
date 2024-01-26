from django.db import connections
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .serializers import CommentSerializer

@api_view(['POST'])
def postComment(request):
    serializer = CommentSerializer(data=request.data)
    if serializer.is_valid():
        validated_data = serializer.validated_data
        content = validated_data["content"],
        rating = validated_data["rating"],
        
        connection = connections['default']
        try:
         with connection.cursor() as cursor:
            cursor.execute("INSERT INTO comment_comment (content,rating) VALUES (%s,%s)",
                       [content,rating])
    
            return Response({"message": "Comment posted successfully","data":validated_data})
        except:
         return Response({"message": "Error occurred while posting comment"})
    else:
      return Response({"message": "Invalid credentials", "errors": serializer.errors}, status=400)


@api_view(['GET'])
def getComments(request):
    connection = connections['default']
    try:
     with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM comment_comment")
        comments = cursor.fetchall()
        return Response({"message": "Comments fetched successfully","data":comments})
    except:
     return Response({"message": "Error occurred while fetching comments"})
