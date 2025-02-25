import React, { useEffect, useState } from 'react';
import { useParams } from "react-router-dom";
import { fetchData } from '../api';
import './MoviePage.css'

function capitalize(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

function extractDomain(url) {
  try {
    const urlObj = new URL(url);
    const hostname = urlObj.hostname;
    const parts = hostname.split('.');

    // Handle cases like "www.example.com" or "example.co.uk"
    let domain = parts.slice(-2).join('.');

    // Extract just the "example" part
    domain = domain.split('.')[0];

    return domain;
  } catch (error) {
    // Handle invalid URLs
    console.error("Invalid URL:", error);
    return null; // Or some other appropriate error value
  }
}

function crop(text) {
  const size = 1300;
  if (text.lenght < size) {
    return text;
  }
  const sub = text.substring(0, size);

  for (let i = size - 1; i >= 0; i--) {
    if (sub[i] == ".") {
        return sub.substring(0, i) + "...";
    }
  }
  return sub;
}


const MoviePage = ({ match }) => {
  const [movie, setMovie] = useState(null);
  const [trailer, setTrailer] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [loadingTrailer, setLoadingTrailer] = useState(false);
  const [trailerError, setTrailerError] = useState(null);
  const params = useParams();
  const movieId = params.id;

  let url = process.env.REACT_APP_API_URL;
  if (url === undefined) {
      url = "http://localhost:5051";
  }

  useEffect(() => {
    const fetchMovie = async () => {
      setLoading(true);
      try {
        const { data } = await fetchData(url + `/api/movie/${movieId}/`);
        setMovie(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
   };
    fetchMovie();
  }, [movieId]);

  const loadTrailer = async () => {
    setLoadingTrailer(true);
    setTrailerError(null);
    try {
      const trailer_response = await fetch(url + `/api/movie/${movieId}/trailer/`);
      if (!trailer_response.ok) {
        throw new Error('Failed to load trailer');
      }
      const trailer_data = await trailer_response.json();
      setTrailer(trailer_data);
    } catch (err) {
      setTrailerError(err.message);
    } finally {
      setLoadingTrailer(false);
    }
  };

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
        cover = <img alt="cover" src={link.url} height="281" width="190"/>;
    }
  }

  const keywords = [];
  const present = {
    'actor': 'Actors',
    'staff': 'Staff',
    'genre': 'Genre',
  }
  for (const [key, value] of tag_metadata.entries()) {
    if (present[key] === undefined) {
      continue;
    }
    keywords.push(
      <p><strong>{present[key]}:</strong> {value.join(', ')}</p>
    );
  }
  const providers = []
  for (const link of movie["links"]) {
    if (link.label !== "Provider") {
      continue
    };
    providers.push(
      <div><a href={link.url}>{capitalize(extractDomain(link.url))}</a></div>
    );
  }
  keywords.push(<div><strong>Available On:</strong> {providers}</div>)

  return (
    <>
    <h2>{movie.title}・({movie.release_year})・{movie.runtime} minutes</h2>
    {cover}
    {movie ? (
      <>
        <div className="movie-media-trailer">
          {trailer ? (
            <video controls autoplay="" name="media" className="movie-media-item">
              <source src={trailer.url} type="video/mp4" />
            </video>
          ) : (
            <div>
              <button onClick={loadTrailer} disabled={loadingTrailer}>
                {loadingTrailer ? 'Loading Trailer...' : 'Load Trailer'}
              </button>
              {trailerError && <div className="error">{trailerError}</div>}
            </div>
          )}
        </div>
      </>
    ) : (
      <div>No movie found.</div>
    )}
    <p><strong>Rating:</strong> {movie.rating / 100}</p>
    {keywords}
    { movie.description ? (
        <>
          <h2>Synopsis</h2>
          <p>{crop(movie.description)}</p>
        </>
        ) : (
          <></>
        )
    }
    </>
  );
};

export default MoviePage;

