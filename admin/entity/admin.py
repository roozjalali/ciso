from django.contrib import admin
from .models import *

# Register your models here.
@admin.register(Company, Profile, Invite, ActivityLog)
class ModelsAdmin(admin.ModelAdmin):
	pass
