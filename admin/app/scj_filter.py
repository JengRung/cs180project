from posixpath import splitdrive
from . import scj_parcer
import bisect
import time
"""
prev_sorted_data = {
    "genres" : {
        "action": [anime data sorted by score],
        "space": [anime data sorted by score],
    },
    "type" : {
        "TV": [anime data sorted by score],
    },
}

"""
prev_sorted_data = {
    "genres" : {},
    "types" : {},
}

def handle_change(action,anime_obj):
    #this means look inside prev_sorted_data["genres"] and check if anime_obj["Genres"] are inside and update accordingly
    update_prev_data_map_with_list(action,anime_obj,"genres","Genres")
    update_prev_data_map(action,anime_obj,"types","Type")

"""
    Parameters
            ----------
            arr : list
                list of anime maps 
            score : str
                score of anime you want to insert into this list
    Return
            ----------
            return the index in where you would insert this score  
"""
def binary_search(arr, score):
    scores_list = [float(i['Score']) for i in arr]
    scores_list.reverse()
    return len(scores_list)- bisect.bisect_left(scores_list, float(score))
"""
    Parameters
            ----------
            type : str
                type could be "Genres" or "Types"
            map : str
                name of the map you want to check for updates
    Return
            ----------
            no return, just updates maps accordingly
"""
def update_prev_data_map_with_list(action,anime_obj,map,type):
    # values is a list
    values = anime_obj[type]
    for value in values:
        if value.lower() in prev_sorted_data[map]:
            sorted_list = prev_sorted_data[map][value.lower()]
            if action == "update" or action == "delete":
                i = 0
                while i < len(sorted_list):
                    if anime_obj['Name'] == sorted_list[i]['Name']:
                        prev_sorted_data[map][value.lower()].remove(sorted_list[i])
                        i = len(sorted_list)
                    i+=1
                        
            if action == "insert" or action == "update":
                # do binary search to see where to append, not just append at the end
                l = prev_sorted_data[map][value.lower()]
                l.insert(binary_search(sorted_list,anime_obj["Score"]),anime_obj)
                prev_sorted_data[map][value.lower()] = l

def update_prev_data_map(action,anime_obj,map,type):
    value = anime_obj[type].lower() 
    if value in prev_sorted_data[map]:
        sorted_list = prev_sorted_data[map][value]
        if action == "update" or action == "delete":
            i = 0
            while i < len(sorted_list):
                if anime_obj['Name'] == sorted_list[i]['Name']:
                    prev_sorted_data[map][value.lower()].remove(sorted_list[i])
                    i = len(sorted_list)
                i+=1
        if action == "insert" or action == "update":
            # do binary search to see where to append, not just append at the end
            l = prev_sorted_data[map][value.lower()]
            print("insertgin @",binary_search(sorted_list,anime_obj["Score"]))
            l.insert(binary_search(sorted_list,anime_obj["Score"]),anime_obj)
            prev_sorted_data[map][value.lower()] = l


# Analytic functions
# Feature 1: As a user, I want to know what the top 100 anime is for a specified genre
def sort_by_score_genre(target_genre, n):
    start = time.time()
    if target_genre.lower() in prev_sorted_data["genres"]:
        print("loading existing genre list")
        end = time.time()
        print("Time in seconds for feature 1:", end - start)
        return prev_sorted_data["genres"][target_genre.lower()][:int(n)+1]
    animes = []
    for anime in scj_parcer.search_by_genres(target_genre):
        if anime['Score'] == 'Unknown':
            anime['Score'] = '-1'
        animes.append(anime)
    output = sorted(animes, key=lambda a: a['Score'], reverse=True)
    prev_sorted_data["genres"][target_genre.lower()] = output

    end = time.time()
    print("Time in seconds for feature 1:", end - start)
    return output[:int(n)]


# Feature 2: As a user, I want to know what the top 100 anime is for a specified type
def sort_by_score_type(target_type, n):
    start = time.time()
    if target_type.lower() in prev_sorted_data["types"]:
        print("loadin existing type list")
        end = time.time()
        print("Time in seconds for feature 1:", end - start)
        return prev_sorted_data["types"][target_type.lower()][:int(n)+1]
    animes = []
    for anime in scj_parcer.search_by_type(target_type):
        if anime['Score'] == 'Unknown':
            anime['Score'] = '-1'
        animes.append(anime)
    output = sorted(animes, key=lambda a: a['Score'], reverse=True)
    prev_sorted_data["types"][target_type.lower()] = output
    print("creating new sorted types list")

    end = time.time()
    print("Time in seconds for feature 2:", end - start)
    return output[:int(n)]

# Feature 3: As a user, I want to know what the top 100 anime is for a specified studio
def top_n_highest_average_anime_by_studio(studio,n):
    animes = []
    for anime in scj_parcer.get_list():
        anime_studios = anime.get('Studios', [])
        if studio in anime_studios:
            if anime['Score'] == 'Unknown':
                anime['Score'] = '-1'
            animes.append(anime)

        anime_producers = anime.get('Producers', [])    
        if studio in anime_producers:
            if anime['Score'] == 'Unknown':
                anime['Score'] = '-1'
            animes.append(anime)
            
    animes = sorted(animes, key=lambda a: a['Score'], reverse=True)
    return animes[:int(n)]
        
# Feature 4: As a user, I want to know what the top 100 anime is for a specified rating
def top_n_highest_average_anime_by_rating(rating,n):
    rating_dict = {
        "G" : "G - All Ages",
        "PG" : "PG - Children",
        "PG-13" : "PG-13 - Teens 13 or older",
        "R" : "R - 17+ (violence & profanity)",
    }
    animes = []
    for anime in scj_parcer.get_list():
        _rating = anime.get('Rating', "")
        if rating_dict[rating] == _rating:
            if anime['Score'] == 'Unknown':
                anime['Score'] = '-1'
            animes.append(anime)
    animes = sorted(animes, key=lambda a: a['Score'], reverse=True)
    return animes[:int(n)]


# Feature 5: As a user, I want to know what is the average duration for the top 10 anime in a given genre.
def average_duration_by_top(target_genre, n):
    times = []  
    sorted_genre_list = sort_by_score_genre(target_genre,n)
    for anime in sorted_genre_list:
        temp =  anime.get('Duration')
        eps = anime.get('Episodes')
        if temp == "Unknown":
            continue
        if temp[3:4] == 'm':
            duration = temp[0:2]
            duration = float(duration)
        elif temp[2:3] == 'h':
            duration = temp[0:1]
            duration = float(duration)
            duration = duration * 60
        else:
            duration = 0
        if eps != "Unknown":
            try:
                duration = duration * float(eps)  
            except:
                duration = 0
        times.append(duration)
    n = int(n)
    total = 0
    for i in range(len(times)):
        total += times[i]
    if len(times) == 0:
        return 0
    return float(total) / len(times)


# Feature 6 & 7: As a user, I want to know which anime has the highest completion rate for every given genre.
def sort_by_completion_rate(target_genre,n):
    animes = []
    for anime in scj_parcer.get_list():
        genres = [x.lower() for x in anime.get('Genres', [])]
        if target_genre.lower() in genres:
            watching = anime.get('Watching')
            completed = anime.get('Completed')
            onHold = anime.get('On-Hold')
            dropped = anime.get('Dropped')
            score = 0
            total = int(watching) + int(completed) + int(onHold) + int(dropped)
            if total != 0:
                score = float(completed) / float(total)
            animes.append((anime,score))   
    animes = sorted(animes, key=lambda a: a[1], reverse=True)
    results = []
    for i in range(int(n)):
        results.append(animes[i][0])
    return results           
