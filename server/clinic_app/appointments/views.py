from .serializers import PatientSerializer, FileSerializer, UpdateRequestStatusSerializer,UpdateAppointmentStatusSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.db import connection
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
@api_view(['POST'])
def book_appointment(request):
    patient_data = request.data['patient']
    date_time = request.data['date_time']
    status = request.data['patient_status']
    message = request.data['message']

    # Validate patient data 
    patient_serializer = PatientSerializer(data=patient_data)
    if not patient_serializer.is_valid():
        return Response({'message': 'Invalid patient data', 'errors': patient_serializer.errors}, status=400)
    
    

    patient = patient_serializer.save()
    with connection.cursor() as cursor:
        cursor.execute("""
                       INSERT INTO appointments_patient (first_name,last_name,phone_number, email, address,birthday_date)
                          VALUES (%s, %s, %s, %s, %s, %s)
                       """, (
            patient.first_name,
            patient.last_name,
            patient.phone_number,
            patient.email,
            patient.address,
            patient.birthday_date
        ))

    with connection.cursor() as cursor:
        cursor.execute("""
            INSERT INTO appointments_request (patient_id, date_time, patient_status, message, request_status)
            VALUES (%s, %s, %s, %s, %s)
            RETURNING id
        """, (
            patient.id,
            date_time,
            status,
            message,
            'waiting'
        ))
        request_id = cursor.fetchone()[0]

    return Response({'request_id': request_id}, status=201)


@api_view(['POST'])
def update_request_status(request, request_id):
    serializer = UpdateRequestStatusSerializer(data=request.data) 
    if serializer.is_valid():
        new_status = serializer.validated_data['new_status'] ##
        info = serializer.validated_data['information']

        with connection.cursor() as cursor:
            cursor.execute("""
                UPDATE appointments_request
                SET request_status = %s
                WHERE id = %s
            """, (new_status, request_id))
        if new_status == 'accepted':
         with connection.cursor() as cursor:
            cursor.execute("""
                SELECT patient_id, date_time, patient_status, message
                FROM yourapp_request
                WHERE id = %s
            """, (request_id,))
         with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO appointments_appointment (request_id, information, status)
                VALUES (%s, %s, %s)
                RETURNING id
            """, (request_id,info, 'waiting'))

        return Response({'message': 'Request status updated successfully'}, status=200)
    else:
        return Response({'message': 'Invalid data for request', 'errors': serializer.errors}, status=400)

@api_view(['POST'])
def update_appointment_status(request, appointment_id):

    serializer = UpdateAppointmentStatusSerializer(data=request.data)
    if serializer.is_valid():
        new_status = serializer.validated_data['new_status']


        with connection.cursor() as cursor:
            cursor.execute("""
                UPDATE appointments_appointment
                SET status = %s
                WHERE id = %s
            """, (new_status, appointment_id))

        return Response({'message': 'Appointment status updated successfully'}, status=200)
    else:
        return Response({'message': 'Invalid data for appointemnt', 'errors': serializer.errors}, status=400)
    


@api_view(['POST'])
def add_file(request):
    name = request.data['name']
    path = request.data['path']
    appointment_id = request.data['appointment_id']

    file_data = {'name': name, 'path': path, 'appointment': appointment_id}
    file_serializer = FileSerializer(data=file_data)
    if not file_serializer.is_valid():
        return Response({'message': 'Invalid file data', 'errors': file_serializer.errors}, status=400)

    file_serializer.save()
    with connection.cursor() as cursor:
        cursor.execute("""
            INSERT INTO appointments_file (name, path, appointment_id)
            VALUES (%s, %s, %s)
        """, (name, path, appointment_id))

    return Response({'message': 'File added successfully'}, status=201)