import csv
from glob import glob
import json
from pathlib import Path
import time

import requests
from bs4 import BeautifulSoup as bs

MOVIES = "title.basics.tsv"
RATINGS = "title.ratings.tsv"
NAMES = "name.basics.tsv"
ACTOR_MOVIES = "title.principals.tsv"


HEADERS = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "Accept-Encoding": "gzip, deflate, br, zstd",
    "Sec-Fetch-Dest": "document",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-Site": "none",
    "Sec-Fetch-User": "?1",
    "Upgrade-Insecure-Requests": "1",
    "Accept-Language": "en-GB,en-US;q=0.9,en;q=0.8",
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
}

BASE_URL = "https://www.imdb.com/title/{identifier}/"

TYPE = "movie"

METADATA = Path("metadata")
FAILED = Path("failed")
JSON_DIR = METADATA

# id
FIELDS = (None, None, None, "title", None, "release_year", None, "runtime", None)

def load_file(key):
    file = JSON_DIR / f"{key}.json"
    try:
        with open(file, encoding="utf-8") as jfile:
            data = json.load(jfile)
    except FileNotFoundError as exc:
        raise KeyError(f"{key} was not found") from exc
    except json.decoder.JSONDecodeError as exc:
        print(exc)
        print(f"CRITICAL - Error fetching data from {key}. Ignoring...")
        return {}

    return data

def save_file(filename, data=None, force=False):
    file = JSON_DIR / f"{filename}.json"

    if file.exists() and not force:
        print(f"ERROR - The {file} exists and {force=}")
        return data

    with open(file, "w", encoding="utf-8") as jfile:
        json.dump(data, jfile, ensure_ascii=False, indent="\t")

    return data


def get_files() -> list:
    """
    Get full file path
    """
    return list(map(lambda file: Path(file).name[:-5], glob(str(JSON_DIR  / "*.json"))))

def load_json(files=get_files()):
    """
    Load data
    """
    data = {}
    print(f"INFO - Loading {len(list(files))} files")
    for file in sorted(files):
        game = load_file(file)
        if game:
            data[file] = game
        else:
            print(f"ERROR - No metadata for {file}")
    return data

def save_json(data=None, force=False):
    data = data or {}

    for key, value in data.items():
        save_file(key, value, force)

    return data

def mov(filename):
    with open(filename) as file:
        rd = csv.reader(file, delimiter="\t", quotechar='"')
        for line in rd:
            if line[1] != TYPE:
                continue
            id = line[0]
            mov = METADATA / (str(id) + ".json")
            if not mov.exists():
                continue

            data = load_file(id)
            for index, field in enumerate(line):
                if FIELDS[index]:
                    data[FIELDS[index]] = field
            data["tags"] = line[-1].strip().split(",")
            if line[-1] == "\\N":
                data["tags"] = []
            with open(mov, "w") as file:
                json.dump(data, file, indent=4)

def ratings(filename):
    ids = set()
    with open(filename) as file:
        rd = csv.reader(file, delimiter="\t", quotechar='"')
        for line in rd:
            id = line[0]
            if id == "tconst":
                continue
            rate = float(line[1])
            votes = int(line[2])

            mov = METADATA / Path(id + ".json")
            if not mov.exists():
                continue
            if rate <= 5 or votes < 1000:
                print(f"WARNING - Deleting {id}")
                mov.unlink()
                continue

            ids.add(id)

            with open(mov) as file:
                data = json.load(file)
            data["rating"] = rate

            with open(mov, "w") as file:
                json.dump(data, file, indent=4)
            del data

    for id in get_files():
        mov = METADATA / Path(id + ".json")
        if id not in ids:
            mov.unlink()

def actors():
    relevant = {}
    actor_keys = {
        "self",
        "actor",
        "actress",
    }
    last = -1
    with open(ACTOR_MOVIES) as file:
        rd = csv.reader(file, delimiter="\t", quotechar='"')
        actors = []
        staff = []
        for line in rd:
            key, _, name_id, category, _, chara = line
            file = JSON_DIR / f"{key}.json"

            if not file.exists():
                continue
            if key != last:
                if last != -1:
                    data = load_file(last)
                    data["actors"] = actors
                    data["staff"] = staff
                    save_file(last, data, force=True)
                actors = []
                staff = []

            if category in actor_keys:
                actors.append(name_id)
            elif category == "archive_footage" or category == "archive_sound":
                pass
            else:
                if chara != r'\N':
                    print(line)
                staff.append(name_id)
            last = key

def fix_and_add_names():
    names = {}
    with open(NAMES) as file:
        rd = csv.reader(file, delimiter="\t", quotechar='"')
        for line in rd:
            key, name, _, _, _, _ = line
            names[key] = name
    
    for file in get_files():
        data = load_file(file)
        if "actors" not in data:
            data["actors"] = []
        if "staff" not in data:
            data["staff"] = []
        actors = []
        for item in data["actors"]:
            actor = names.get(item, None)
            if actor:
                actors.append(actor)
        staff = []
        for item in data["staff"]:
            actor = names.get(item, None)
            if actor:
                staff.append(actor)

        data["actors"] = actors
        data["staff"] = staff


        if data["tags"] == ["\\N"]:
            data["tags"] = []
        if data["runtime"] == "\\N":
            data["runtime"] = 0

        save_file(file, data, force=True)

def covers():
    for file in get_files():
        data = load_file(file)
        url = BASE_URL.format(identifier=file)

        if "cover" in data and data["cover"]:
            continue
        try:
            res = requests.get(url, headers=HEADERS)
            soup = bs(res.text, "lxml")
            cover = soup.findAll("img")[1]["src"]
            data["cover"] = cover
        except Exception as exc:
            print(f"ERROR - {file}")
            print(exc)
            continue

        print(file, data)

        save_file(file, data, force=True)

def amazon():
    URL = "https://www.amazon.com/s/?url=search-alias%3Dmovies-tv-intl-ship&field-keywords={title}"
    class_ = "puisg-col puisg-col-4-of-12 puisg-col-8-of-16 puisg-col-12-of-20 puisg-col-12-of-24 puis-list-col-right"

    session = requests.session()
    session.headers.update(HEADERS)

    dvds = []
    for index, item in enumerate(get_files()):
        ua = f"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/{index}.0.0.0 Safari/537.36"
        session.headers["User-Agent"] = ua

        data = load_file(item)
        if "amazon" in data["tags"]:
            continue

        title = data["title"]
        a = data["actors"][0] if data["actors"] else ""
        b = data["staff"][0] if data["staff"] else ""
        query = f"{title} {a} {b}"
        url = URL.format(title=query)
        print(url)

        try:
            session.get("https://www.amazon.com").raise_for_status()
        except Exception as exc:
            print(f"ERROR - {exc}")
            continue

        try:
            res = session.get(url)
            soup = bs(res.text, "lxml")
            if "Prime Video" not in soup.text:
                print(f"ERROR - No valid links {item}")
                name = str(item) + ".html"
                with open(FAILED / name, "w") as file:
                    file.write(res.text)
                continue
        except Exception as exc:
            print(f"ERROR - {item}")
            print(exc)
            continue
        
        movies = soup.findAll(class_=class_)
        id = item
        print(f"INFO - Getting Amazon link for {id} {url=}")
        mov = METADATA / (str(id) + ".json")
        if "links" not in data:
            data["links"] = []

        movies = movies or []

        flag = False
        dvd_link = None
        for movie in movies:
            pred = any(actor in movie.text for actor in data["actors"]) or any(staff in movie.text for staff in data["staff"])
            assertion = any(actor in movie.text for actor in data["actors"]) and any(staff in movie.text for staff in data["staff"])
            if pred:
                if not assertion:
                    print(f"WARNING - Couldn't assert if this is the actual movie! {id=}")
                link = "https://www.amazon.com" + "/".join(movie.a["href"].split("/")[:-1])
                flag = True
                if "DVD" in movie.text and not dvd_link:
                    flag = False
                    print(f"WARNING - DVD {id}")
                    dvd_link = link
                    continue
                if link not in data["links"]:
                    data["links"].append(link)
                data["tags"].append("amazon")
                print(f"INFO - Got valid link for {id}")
                break


        if not flag:
            if dvd_link and not data["links"]:
                print(f"WARNING - Adding dvd link to {id}")
                dvds.append(id)
                data["links"] = dvd_link

            print(f"WARNING - Falied to get Amazon link for {id}")
            name = str(id) + ".html"
            with open(FAILED / name, "w") as file:
                file.write(res.text)

        dvd_link = None
        save_file(id, data, force=True)


    with open("dvd.json", "w", encoding="utf-8") as jfile:
        json.dump(dvds, jfile, ensure_ascii=False, indent="\t")


def get_data(url):
    WAIT = 1
    try:
        res = requests.get(url)
        res.raise_for_status()
        time.sleep(WAIT)
    except Exception as exc:
        print(f"ERROR - {exc} {BASE_URL=}")
        
        return (None, None)

    soup = bs(res.text, "lxml")

    return res, soup


def netflix():
    BASE_URL = "https://flixwatch.co/"
    URL = BASE_URL + "?s={title}&id={token}"

    WAIT = 1

    session = requests.session()
    session.headers.update(HEADERS)

    for index, item in enumerate(get_files()):
        ua = f"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/{index}.0.0.0 Safari/537.36"
        session.headers["User-Agent"] = ua

        id = item
        data = load_file(item)
        title = data["title"]
        if "netflix" in data["tags"]:
            continue
        url = BASE_URL
        res, soup = get_data(url)
        if not res:
            continue
        hidden = soup.find(type="hidden")
        token = hidden["value"]

        url = URL.format(title=title, token=token)

        res, soup = get_data(url)

        print(f"INFO - Trying {id=}")

        content = soup.find(id="content")

        if not content:
            print(f"INFO - Failed to find links for {id=}")
            continue

        for link in content.findAll("a"):
            if not f'({data["release_year"]})' in link.text:
                continue

            url = link["href"]
            print(f"INFO - Found {url}")

            main_res, main_soup = get_data(url)

            country_list = main_soup.find(id="amp-list")
            if country_list is None:
                print("ERROR - Couldn't find country list {id=}")
                continue
            url = country_list["src"]
            res, soup = get_data(url)
            try:
                countries = res.json()
            except Exception as exc:
                print(exc, url, res.text)
                continue

            if "nexflix" not in data:
                data["netflix"] = []
            for country in countries["items"]:
                try:
                    slug = country["url"].split("/")[-2]
                except IndexError:
                    print(f"ERROR - Failed to get country {country=}")
                    continue
                if slug not in data["netflix"]:
                    data["netflix"].append(slug)
                print(f"INFO - Country for {id=} {country}")

            status = main_soup.find(id="streaming-status")
            if not status:
                print(f"ERROR - Failed to get streaming info {id=}")
                name = str(id) + ".html"
                with open(FAILED / name, "w") as file:
                    file.write(main_res.text)
                continue
            
            url = status["src"]
            res, soup = get_data(url)

            try:
                netflix = res.json()
            except Exception as exc:
                print(exc, url, res.text)
                continue

            for item in netflix["items"]:
                if item["title"] == "Watch on Netflix":
                    stream_url =  item["url"][0]
                    print(f"INFO - Added {stream_url}")
                    if stream_url not in data["links"]:
                        data["links"].append(stream_url)
                    data["tags"].append("netflix")
            break
        mov = METADATA / (str(id) + ".json")
        save_file(id, data, force=True)


def valid_hbo(movie: dict, data):
    url = movie
    res, soup = get_data(url)
    
    if not soup:
        return False

    cast = soup.find(class_="readMore")
    
    if not cast:
        print(f"WARNING - No cast for {movie=}")
        return False

    cast = cast.text

    pred = any(actor in cast for actor in data["actors"]) or any(staff in cast for staff in data["staff"])
    assertion = any(actor in cast for actor in data["actors"]) and any(staff in cast for staff in data["staff"])
    if not pred:
        print(f"WARNING - {movie=} is not {data['title']}")
        return False
    if not assertion:
        print(f"WARNING - Couldn't assert if this is the actual movie! {movie=}")
    return True

def hbo_max():
    BASE_URL = "https://www.max.com"
    url = "https://www.max.com/sitemap/movies"


    res, soup = get_data(url)
    links = soup.find(class_="my-5 container").findAll("a")
    counter = 0

    for id in get_files():
        data = load_file(id)
        if "max" in  data["tags"]:
            continue
        for movie in links:
            link = BASE_URL + movie["href"]
            if data["title"] in movie.text and valid_hbo(link, data):
                print(f"INFO - Found link for {id=} {link=}")

                if "links" not in data:
                    data["links"] = []
                if link not in data["links"]:
                    data["links"].append(link)
                data["tags"].append("max")
                counter += 1
                break
        mov = METADATA / (str(id) + ".json")
        save_file(id, data, force=True)

#mov(MOVIES)
#ratings(RATINGS)
#actors()
#fix_and_add_names()
#covers()
#amazon()
# assert actors
#netflix()
#hbo_max()
