# Generated by Django 4.2.8 on 2024-01-28 13:54

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("appointments", "0002_alter_appointment_information"),
    ]

    operations = [
        migrations.AlterField(
            model_name="appointment",
            name="information",
            field=models.CharField(max_length=255, null=True),
        ),
    ]
