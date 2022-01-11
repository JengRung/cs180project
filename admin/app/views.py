from django.db.models import query
from django.http.response import JsonResponse
from django.shortcuts import render
from django.http import HttpResponse
from django.http import HttpRequest
from django.views.decorators.csrf import csrf_exempt
from django.core import serializers
from app.models import Anime
from .serializers import AnimeSerializer
from rest_framework import viewsets
from . import scj_parcer
from . import scj_filter
import os
import json
import shutil
import time

class Anime(viewsets.ModelViewSet):
    queryset = Anime.objects.all()
    serializer_class = AnimeSerializer

    
def hello_world(request):
    return HttpResponse("Hello World!")

def test(request):
    return JsonResponse({'foo':'bar'})

def modify(request):
    return JsonResponse({'foo':'bar'})
    

# [TODO] - michelle - will refactor this in the future 
def search_for_anime(request):
    anime_name = request.GET.get('anime_name')
    if anime_name:
        data = scj_parcer.search_by_name(anime_name)

    producer = request.GET.get('producer')
    if producer:
        data = scj_parcer.search_by_producers(producer)
    genre = request.GET.get('genre')
    if genre:
        data = scj_parcer.search_by_genres(genre)

    score = request.GET.get('score')
    if score:
        data = scj_parcer.search_by_score(score)
    return JsonResponse(data, safe=False)

# C:\Users\Michelle\Documents\CS\CS180\cs180project-021-sea-cream-jasmine\react-app\src\anime.json


def delete(request):
    anime_name = request.GET.get('name')
    if(scj_parcer.delete(anime_name)):
        return HttpResponse(anime_name + " has been deleted")
    else:
        return JsonResponse("Anime not found. Unable to delete",safe=False)

def edit(request):
    anime_name = request.GET.get('name')
    anime_Score = request.GET.get('score')
    anime_Rating = request.GET.get('ranking')
    anime_Episodes = request.GET.get('episode')
    anime_Type = request.GET.get('type')
    anime_Popularitys = request.GET.get('popularity')
    anime_Genre = request.GET.get('genre')
    anime_Studio = request.GET.get('studio')
    if(scj_parcer.update(anime_name, anime_Score, anime_Rating, anime_Episodes, anime_Type, anime_Popularitys, anime_Genre, anime_Studio)):
        return HttpResponse(anime_name + " has been updated")
    else:
        return JsonResponse("Anime not found. Unable to update",safe=False)

def insert(request):
    anime_name = request.GET.get('name')
    anime_Score = request.GET.get('score')
    anime_Rating = request.GET.get('ranking')
    anime_Episodes = request.GET.get('episode')
    anime_Type = request.GET.get('type')
    anime_Popularitys = request.GET.get('popularity')
    anime_Genre = request.GET.get('genre')
    anime_Studio = request.GET.get('studio')
    scj_parcer.insert(anime_name, anime_Score, anime_Rating, anime_Episodes, anime_Type, anime_Popularitys, anime_Genre, anime_Studio)
    return HttpResponse(anime_name + " has been added to the database")
   

def backup_data(request):
    if(scj_parcer.backup_data()):
        return JsonResponse("Data has been backup-ed.",safe=False)
    return JsonResponse("Data backup process fail.",safe=False)


def import_data(request):
    if(scj_parcer.import_data()):
        return JsonResponse("Data has been imported.",safe=False)
    return JsonResponse("Data backup process fail.",safe=False)

def filter_score_by_genre(request):
    data = []
    n  = request.GET.get('n') 
    genre = request.GET.get('value')

    if genre and n:
        data = scj_filter.sort_by_score_genre(genre, n)

    return JsonResponse(data, safe=False)

def filter_score_by_type(request):
    data = []
    n  = request.GET.get('n') 
        
    anime_type = request.GET.get('value')
    if anime_type and n:
        data = scj_filter.sort_by_score_type(anime_type, n)

    return JsonResponse(data, safe=False)

def top_n_anime_by_studio(request):
    data = []
    studio  = request.GET.get('value')
    n  = request.GET.get('n') 
    if studio and n:
        data = scj_filter.top_n_highest_average_anime_by_studio(studio,n)

    return JsonResponse(data,safe=False)

def sort_by_completion_rate_type(request):
    data = []
    animeType  = request.GET.get('value')

    n  = request.GET.get('n') 
    if animeType and n:
        data = scj_filter.sort_by_completion_rate_type(animeType,n)
    return JsonResponse(data,safe=False)


def top_n_anime_by_anime_rating(request):
    data = []
    rating  = request.GET.get('value')
    n  = request.GET.get('n') 
    if rating and n:
        data = scj_filter.top_n_highest_average_anime_by_rating(rating,n)
    return JsonResponse(data,safe=False)

def completion_rate_by_genre(request):
    data = []
    genre = request.GET.get('value')
    n = request.GET.get('n')
    if genre and n:
        data = scj_filter.sort_by_completion_rate(genre,n)
    return JsonResponse(data, safe=False)


def average_duration_by_top(request):
    data = []
    genre  = request.GET.get('value')
    n  = request.GET.get('n') 
    if genre and n:
        data = scj_filter.average_duration_by_top(genre, n)
    return JsonResponse(data,safe=False)