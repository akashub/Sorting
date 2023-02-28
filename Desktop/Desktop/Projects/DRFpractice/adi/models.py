from django.db import models

class mockedResponses(models.Model):
    mockJSON = models.JSONField(max_length = 100)
    mockLocation = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.mockJSON
