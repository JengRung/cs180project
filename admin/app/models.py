# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Anime(models.Model):
    id = models.AutoField(unique=True,primary_key=True)
    name = models.TextField(db_column='Name', blank=True, null=True)  # Field name made lowercase.
    score = models.TextField(db_column='Score', blank=True, null=True)  # Field name made lowercase.
    genres = models.TextField(db_column='Genres', blank=True, null=True)  # Field name made lowercase.
    english_name = models.TextField(db_column='English name', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    japanese_name = models.TextField(db_column='Japanese name', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    mal_id = models.IntegerField(db_column='MAL_ID', blank=True, null=True)  # Field name made lowercase.
    episodes = models.TextField(db_column='Episodes', blank=True, null=True)  # Field name made lowercase.
    aired = models.TextField(db_column='Aired', blank=True, null=True)  # Field name made lowercase.
    premiered = models.TextField(db_column='Premiered', blank=True, null=True)  # Field name made lowercase.
    producers = models.TextField(db_column='Producers', blank=True, null=True)  # Field name made lowercase.
    licensors = models.TextField(db_column='Licensors', blank=True, null=True)  # Field name made lowercase.
    studios = models.TextField(db_column='Studios', blank=True, null=True)  # Field name made lowercase.
    source = models.TextField(db_column='Source', blank=True, null=True)  # Field name made lowercase.
    type = models.TextField(db_column='Type', blank=True, null=True)  # Field name made lowercase.
    rating = models.TextField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.
    ranked = models.TextField(db_column='Ranked', blank=True, null=True)  # Field name made lowercase.
    popularity = models.IntegerField(db_column='Popularity', blank=True, null=True)  # Field name made lowercase.
    duration = models.TextField(db_column='Duration', blank=True, null=True)  # Field name made lowercase.
    favorites = models.IntegerField(db_column='Favorites', blank=True, null=True)  # Field name made lowercase.
    watching = models.IntegerField(db_column='Watching', blank=True, null=True)  # Field name made lowercase.
    completed = models.IntegerField(db_column='Completed', blank=True, null=True)  # Field name made lowercase.
    on_hold = models.IntegerField(db_column='On-Hold', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    dropped = models.IntegerField(db_column='Dropped', blank=True, null=True)  # Field name made lowercase.
    plan_to_watch = models.IntegerField(db_column='Plan to Watch', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_10 = models.TextField(db_column='Score-10', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    members = models.IntegerField(db_column='Members', blank=True, null=True)  # Field name made lowercase.
    score_8 = models.TextField(db_column='Score-8', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_7 = models.TextField(db_column='Score-7', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_6 = models.TextField(db_column='Score-6', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_9 = models.TextField(db_column='Score-9', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_4 = models.TextField(db_column='Score-4', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_3 = models.TextField(db_column='Score-3', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_2 = models.TextField(db_column='Score-2', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_1 = models.TextField(db_column='Score-1', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    score_5 = models.TextField(db_column='Score-5', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.

    class Meta:
        managed = False
        db_table = 'anime'


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)
    name = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()
    first_name = models.CharField(max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    action_flag = models.PositiveSmallIntegerField()

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'
