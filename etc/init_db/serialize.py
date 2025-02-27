import json
import random

from movieapp.api import Client

from build import get_files, load_file

data = get_files()


client = Client()

actors = set()

for file in data:
    entry = load_file(file)
    title = entry["title"]
    description = entry.get("generated_summary", "")
    if isinstance(description, dict):
        # handle AI errors
        description = description["description"]
    release_year = int(entry["release_year"])
    movie = client.get_or_create_movie(
        title=title,
        description=description,
        release_year=release_year,
        runtime=int(entry["runtime"]),
        rating=entry["rating"]*100,
        votes=entry["votes"],
    )
    client.session.commit()
    for star in set(entry["actors"]):
        star = star.strip()
        if star not in actors:
            actors.add(star)
            tag = client.get_or_create_tag(name=star, category="actor")
            client.session.commit()
        else:
            tag = client.get_tag(name=star).one()
        client.create_tagged_movie(movie_id=movie.id, tag_id=tag.id)
        client.session.commit()

    for star in set(entry["staff"]):
        star = star.strip()
        if star not in actors:
            actors.add(star)
            tag = client.get_or_create_tag(name=star, category="staff")
            client.session.commit()
        else:
            tag = client.get_tag(name=star).one()
        client.create_tagged_movie(movie_id=movie.id, tag_id=tag.id)
        client.session.commit()

    cover = entry.get("cover", None)
    if cover:
        client.create_link(movie=movie, url=cover, label="Cover")
    for link in entry["links"]:
        client.create_link(movie=movie, url=link, label="Provider")

    client.create_link(movie=movie, url=f"https://imdb.com/title/{file}/", label="Metadata")

    for tag_name in set(entry["tags"]):
        category = "genre"
        if tag_name in {"max", "amazon", "netflix"}:
            category = "provider"
        tag = client.get_or_create_tag(name=tag_name.lower(), category=category)
        client.session.commit()
        client.create_tagged_movie(movie_id=movie.id, tag_id=tag.id)
        client.session.commit()
    client.session.commit()
