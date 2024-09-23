import json
from movieapp.api import Client
import random

with open("data.json") as file:
    data = json.load(file)


client = Client()

actors = set()

for entry in data:
    title = entry["title"]
    release_year = entry["release_year"]
    movie = client.create_movie(
        title=title,
        release_year=release_year,
        runtime=random.randint(60, 180),
        rating=random.randint(300, 500)
    )
    for star in entry["stars"]:
        star = star.strip()
        if star in actors:
            continue
        actors.add(star)
        tag = client.create_tag(name=star, category="actor")
        client.session.commit()
        client.create_tagged_movie(movie_id=movie.id, tag_id=tag.id)

    client.create_link(movie=movie, url=entry["img"], label="Cover")

client.session.commit()

tags = []
for tag in ["tag_" + str(i) for i in range(10)]:
    tags.append(client.create_tag(name=tag, category="keyword"))

client.session.commit()

for movie in client.get_movie().all():
    for _ in range(3):
        tag = tags[random.randint(0, 9)]
        client.create_tagged_movie(movie_id=movie.id, tag_id=tag.id)

client.session.commit()
