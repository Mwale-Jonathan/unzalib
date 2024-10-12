from django.db import models
from django.contrib.auth.models import AbstractUser


# Create your models here.
class User(AbstractUser):
    email = models.EmailField(max_length=254, unique=True, verbose_name="Email Address")
    username = models.CharField(
        max_length=150,
        unique=False,
        verbose_name="Name",
        help_text="e.g Mwale Jonathan",
    )
    image = models.ImageField(
        upload_to="profile-pics", default="profile-pics/default.png"
    )

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = [
        "username",
    ]

    def __str__(self):
        return self.username
