from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    image = models.ImageField(upload_to='user_images/', null=True, blank=True)
    role = models.CharField(max_length=50, choices=[('Student', 'Student'), ('Faculty', 'Faculty'), ('Staff', 'Staff')])

class Author(models.Model):
    name = models.CharField(max_length=255)
    biography = models.TextField(blank=True)

class Publisher(models.Model):
    name = models.CharField(max_length=255)
    address = models.TextField()

class Book(models.Model):
    isbn = models.CharField(max_length=13, unique=True)
    title = models.CharField(max_length=255)
    cover = models.ImageField(upload_to='book_covers/', null=True, blank=True)
    authors = models.ManyToManyField(Author, related_name='books')
    publisher = models.ForeignKey(Publisher, on_delete=models.SET_NULL, null=True, related_name='books')
    publication_year = models.IntegerField()

class BookCopy(models.Model):
    book = models.ForeignKey(Book, on_delete=models.CASCADE, related_name='copies')
    status = models.CharField(max_length=50, choices=[
        ('Available', 'Available'),
        ('Checked Out', 'Checked Out'),
        ('Reserved', 'Reserved'),
        ('Under Maintenance', 'Under Maintenance')
    ])
    condition = models.CharField(max_length=50, choices=[
        ('New', 'New'),
        ('Good', 'Good'),
        ('Fair', 'Fair'),
        ('Poor', 'Poor')
    ])
    location = models.CharField(max_length=255)
    timestamp = models.DateTimeField(auto_now_add=True)

class Loan(models.Model):
    book_copy = models.ForeignKey(BookCopy, on_delete=models.CASCADE, related_name='loans')
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='loans')
    checkout_date = models.DateField()
    due_date = models.DateField()
    return_date = models.DateField(null=True, blank=True)
    status = models.CharField(max_length=50, choices=[
        ('Active', 'Active'),
        ('Returned', 'Returned'),
        ('Overdue', 'Overdue')
    ])

class Fine(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='fines')
    loan = models.ForeignKey(Loan, on_delete=models.CASCADE, related_name='fines')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=50, choices=[('Pending', 'Pending'), ('Paid', 'Paid')])
    timestamp = models.DateTimeField(auto_now_add=True)
