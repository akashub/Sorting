from django.shortcuts import render
from rest_framework import generics

from .models import mockedResponses
from .serializers import MockSerializer


# a lot of this doesn't make sense.
class mockList(generics.ListAPIView):
    serializer_class = MockSerializer

    def get_queryset(self, *args, **kwargs):
        mock_location = kwargs.get("mockLocation")
        queryset = mockedResponses.objects.filter(location=mock_location)
        return queryset

class mockCreate(generics.CreateAPIView):
    serializer_class = MockSerializer
