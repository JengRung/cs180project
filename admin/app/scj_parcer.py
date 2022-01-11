import os
import json

from . import scj_filter

path = os.path.join(os.path.dirname(os.path.realpath(__file__)), './database/anime.csv')
pathJson = os.path.join(os.path.dirname(os.path.realpath(__file__)), '../../react-app/src/anime.json')

# data = {}
results = []
category_arr = []

# category_arr = [MAL_ID,Name,Score,Genres,English name,Japanese name,Type,Episodes,Aired,Premiered,Producers,Licensors,Studios,Source,Duration,Rating,Ranked,Popularity,Members,Favorites,Watching,Completed,On-Hold,Dropped,Plan to Watch,Score-10,Score-9,Score-8,Score-7,Score-6,Score-5,Score-4,Score-3,Score-2,Score-1]
with open(path, 'r', encoding="UTF-8") as file:
    lineNum = 0
    listStart = False
    for line in file:
        category_index = 0
        words = line.split(',')
        if lineNum == 0:
            category_arr = words
        else:
            anime_dict={}
            for i in range(len(category_arr)):
                anime_dict[category_arr[category_index]] = ""
           
            list = []
            for i in range(len(words)):
                if '\"' in words[i]:
                    listStart = not listStart
                curWord = words[i].replace("\"", "") 
                if listStart:
                    list.append(curWord)
                else:
                    if category_arr[category_index] == "Genres" or category_arr[category_index] == "Producers" or category_arr[category_index] == "Licensors"  or category_arr[category_index] == "Studios" :
                        anime_dict[category_arr[category_index]] = []
                        for item in list:
                            anime_dict[category_arr[category_index]].append(item)
                        anime_dict[category_arr[category_index]].append(curWord)
                        list = []
                    else:
                        anime_dict[category_arr[category_index]] =curWord
                    category_index+=1
            results.append(anime_dict)
        lineNum += 1

def generateJson():
    with open(pathJson, 'w') as fp:
        json.dump(results, fp, indent=4)

# Getting the anime dictionary list
def get_list():
    return results

# Search Functions
def search_by_name(target_name):
    for rows in results:
        if(rows.get('Name') == target_name):
            return rows

def search_by_score(target_score):
    animes = []
    for anime in results:
        score = anime.get('Score',"")
        if target_score == score:
            animes.append(anime)
    return animes 

def search_by_producers(target_producer):
    animes = []
    for anime in results:
        producer = anime.get('Producers',[])
        for i in range(len(producer)):
            produce = producer[i]
            if produce[0] == ' ':
                produce = produce[1:]
            if produce.lower() == target_producer.lower():
                animes.append(anime)
                break
    return animes 

def search_by_genres(target_genre):
    animes = []
    for anime in results:
        genres = anime.get('Genres',[])
        for i in range(len(genres)):
            genre = genres[i]
            if genre[0] == ' ':
                genre = genre[1:]
            if genre.lower() == target_genre.lower():
                animes.append(anime)
                break
    return animes 

def search_by_type(target_type):
    animes = []
    for anime in results:
        type = anime.get('Type',"")
        if target_type == type:
            animes.append(anime)
    return animes 

# Modify Page Functions
# Call this function to delete data by name
def delete(target_name):
    for i in range(len(results)):
        if 'Name' in results[i] and results[i]['Name'] == target_name:
            temp = results[i]
            del results[i]
            scj_filter.handle_change("delete",temp)
            return temp
    return {}

# Call this function to update data
def update(anime_name, score, ranking, episodes, type, popularity, genre, studio):
    for i in range(len(results)):
        if 'Name' in results[i] and results[i]['Name'] == anime_name:
            if genre == '':
                genre_list = ''
            else:
                genre_list = str(genre).split(',')
                for j in range(len(genre_list)):
                    if genre_list[j][0] == ' ':
                        genre_list[j] = genre_list[j][1:]
                        
            # handle empty input
            if score != "":
                results[i]['Score'] = score
            if ranking != "":
                results[i]['Ranked'] = ranking
            if episodes != "":
                results[i]['Episodes'] = episodes
            if type != "":
                results[i]['Type'] = type
            if popularity != "":
                results[i]['Popularity'] = popularity
            if genre_list != "":
                results[i]['Genres'] = genre_list
            if studio != "":
                results[i]['Studios'] = studio
            scj_filter.handle_change("update",results[i])
            return True
    return False
    

def insert(anime_name, score, ranking, episodes, type, popularity, genre, studio):
    anime_dict={}   
    category_index = 0
    for i in range(len(category_arr)):
        anime_dict[category_arr[category_index]] = ""

    if genre == '':
        genre_list = ''
    else:
        genre_list = str(genre).split(',')
        for i in range(len(genre_list)):
            if genre_list[i][0] == ' ':
                genre_list[i] = genre_list[i][1:]

    anime_dict['Name'] = anime_name
    anime_dict['Score'] = score
    anime_dict['Ranked'] = ranking
    anime_dict['Episodes'] = episodes
    anime_dict['Type'] = type
    anime_dict['Popularity'] = popularity
    anime_dict['Genres'] = genre_list
    anime_dict['Studios'] = studio
    results.append(anime_dict)
    scj_filter.handle_change("insert",anime_dict)
    return True


def backup_data():
    destination = os.path.join(os.path.dirname(os.path.realpath(__file__)), '../../react-app/src/anime.json')
    with open(destination, 'w') as jsonfile:
        json.dump(results, jsonfile, indent=4)
        return True
    return False

# Import the anime.json into local data structure
def import_data():

    destination = os.path.join(os.path.dirname(os.path.realpath(__file__)), '../../react-app/src/anime.json')
    with open(destination, 'r') as jsonfile:
        datas = json.load(jsonfile)
        results.clear()
        for data in datas:
            results.append(data)
        return True

