"""admin URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views
from rest_framework import routers

router = routers.DefaultRouter(trailing_slash=False)
router.register('anime', views.Anime)

urlpatterns = [
    path('', views.hello_world, name='hello_world'),
    path('2/', views.test, name='test'),
    path('anime_search/', views.search_for_anime, name='search_for_anime'),
    path('backup/', views.backup_data, name='backup'),
    path('import/', views.import_data, name='import_data'),
    path('modify/', views.modify, name='modify'),
    path('animeDelete/', views.delete, name='animeDelete'),
    path('animeEdit/', views.edit, name='animeUpdate'),
    path('animeAdd/', views.insert, name='animeInsert'),
    path('filter_score_by_genre/', views.filter_score_by_genre, name='filter_score_by_genre'),
    path('filter_score_by_type/', views.filter_score_by_type, name='filter_score_by_type'),
    path('topAnimeByStudio/', views.top_n_anime_by_studio, name='top_n_anime_by_studio'),
    path('completionRateByType/', views.sort_by_completion_rate_type, name='completionRateByType'),
    path('topAnimeByRating/', views.top_n_anime_by_anime_rating, name='top_n_anime_by_anime_rating'),
    path('completionRate/', views.completion_rate_by_genre, name = 'sort_by_completion_rate'),
    path('averageDuration/', views.average_duration_by_top, name = 'average_duration_by_top'),
]
