from rest_framework import serializers
from .models import Patient, Request, Appointment, File

class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = '__all__'

class RequestSerializer(serializers.ModelSerializer):
    patient = PatientSerializer()

    class Meta:
        model = Request
        fields = '__all__'

class AppointmentSerializer(serializers.ModelSerializer):
    request = RequestSerializer()

    class Meta:
        model = Appointment
        fields = '__all__'

class FileSerializer(serializers.ModelSerializer):
    appointment = AppointmentSerializer()

    class Meta:
        model = File
        fields = '__all__'


class UpdateRequestStatusSerializer(serializers.Serializer):
    new_status = serializers.ChoiceField(choices=['accepted', 'declined', 'waiting'])

class UpdateAppointmentStatusSerializer(serializers.Serializer):
    new_status = serializers.ChoiceField(choices=['done', 'cancelled', 'waiting'])