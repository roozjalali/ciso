from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Company(models.Model):
    name = models.CharField(max_length=200)
    website = models.URLField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Profile(models.Model):
    # Extend the built-in Django User model
    user = models.OneToOneField('auth.User', on_delete=models.CASCADE)
    AUTH_CHOICES = [
        ('EMAIL', 'Email/Password'),
        ('SSO', 'Single Sign On'),
        ('MAGIC', 'Magic Link')
    ]

    groups = models.ManyToManyField('auth.Group', blank=True)
    user_permissions = models.ManyToManyField('auth.Permission', blank=True)
    supabase_uid = models.CharField(max_length=255, unique=True)
    email = models.EmailField(unique=True)
    auth_type = models.CharField(max_length=10, choices=AUTH_CHOICES)
    companies = models.ManyToManyField(Company, blank=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', null=True, blank=True)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class Invite(models.Model):
    email = models.EmailField(unique=True)
    company = models.ForeignKey(Company, on_delete=models.CASCADE, related_name='invites')
    invited_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='sent_invites')
    recipient = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='received_invites')
    token = models.CharField(max_length=255, unique=True)
    status = models.CharField(max_length=20, choices=[
        ('PENDING', 'Pending'),
        ('ACCEPTED', 'Accepted'),
        ('DECLINED', 'Declined'),
    ], default='PENDING')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Invite for {self.email} to {self.company.name}"

class ActivityLog(models.Model):
    ACTION_CHOICES = [
        ('CREATE', 'Create'),
        ('UPDATE', 'Update'),
        ('DELETE', 'Delete'),
    ]
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    action = models.CharField(max_length=10, choices=ACTION_CHOICES)
    model_name = models.CharField(max_length=100)
    object_id = models.PositiveIntegerField()
    timestamp = models.DateTimeField(auto_now_add=True)
    description = models.TextField()

    def __str__(self):
        return f"{self.action} on {self.model_name} by {self.user} at {self.timestamp}"