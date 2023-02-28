from django.urls import path
from .views import mockList, mockCreate

urlpatterns = [
    path('mock/create/', mockCreate.as_view()),
    path('mock/<str:mockLocation>', mockList.as_view())
]