import React, { useEffect, useState } from 'react';
import { useParams } from "react-router-dom";

const MoviePage = ({ match }) => {
  const [movie, setMovie] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const params = useParams();
  const movieId = params.id;
  //const movieId = match.id; // Get the movie ID from the URL

  let url = process.env.REACT_APP_API_URL;
  if (url === undefined) {
      url = "http://localhost:5051";
  }

  useEffect(() => {
    const fetchMovie = async () => {
      setLoading(true);
      try {
        const response = await fetch(url + `/api/movie/${movieId}/`); // Fetch details using the ID
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const data = await response.json();
        setMovie(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchMovie();
  }, [movieId]);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (error) {
    return <div className="error">Error: {error}</div>;
  }

  let tag_metadata = new Map();
  for (const tag of movie.tags) {
    if (tag_metadata.has(tag["category"])) {
      tag_metadata.get(tag["category"]).push(tag.name);
    }
    else {
      tag_metadata.set(tag.category, [tag.name]);
    }
  }
  let cover = null;
  for (const link of movie.links) {
    if (link.label === "Cover") {    
        cover = <img alt="cover" src={link.url} />;
    }
  }

  const keywords = [];
  const present = {
    'actor': 'Actors',
    'staff': 'Staff',
    'genre': 'Genre',
    'provider': 'Available On',
  }
  console.log(tag_metadata)
  for (const [key, value] of tag_metadata.entries()) {
    console.log(value);
    keywords.push(
      <p><strong>{present[key]}:</strong> {value.join(', ')}</p>
    );
  }

  for (const link of movie["links"]) {
      if (link.label !== "Cover") {
          keywords.push(<p><a href={link.url}>{link.url}</a></p>);
      }
  }



  console.log(cover);


  return ( 
    <div className="movie-details">
      {movie ? (
        <>
          {cover}
          <h2>{movie.title}・({movie.release_year})・{movie.runtime} minutes</h2>
          {keywords}
          <p><strong>Rating:</strong> {movie.rating}</p>
        </>
      ) : (
        <div>No movie found.</div>
      )}
    </div>
  );
};

export default MoviePage;

