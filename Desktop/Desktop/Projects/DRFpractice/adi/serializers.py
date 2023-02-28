from rest_framework import serializers
from .models import mockedResponses

class MockSerializer(serializers.ModelSerializer):
    class Meta:
        model = mockedResponses
        fields = ('__all__')