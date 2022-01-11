from rest_framework import serializers

from .models import Anime

class AnimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Anime
        fields = [
            'id',
            'name',
            'score',
            'genres',
            'english_name',
            'japanese_name',
            'mal_id',
            'episodes',
            'aired',
            'premiered',
            'producers',
            'licensors',
            'studios',
            'source',
            'type',
            'rating',
            'ranked',
            'popularity',
            'duration',
            'favorites',
            'watching',
            'completed',
            'on_hold',
            'dropped',
            'plan_to_watch',
            'members',
            'score_10',
            'score_9',
            'score_8',
            'score_7',
            'score_6',
            'score_5'
            'score_4',
            'score_3',
            'score_2',
            'score_1',
        ]