import React, { useEffect, useState } from 'react';
import { Link, useSearchParams, useNavigate } from 'react-router-dom';
import './Result.css';
import Trailer from './Trailer' ;

const Result = () => {
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showProviders, setShowProviders] = useState(false);
  const [error, setError] = useState(null);
  const [visibleMovies, setVisibleMovies] = useState(5);

  const [searchParams] = useSearchParams();
  let params = searchParams.get("q");

  if (params === null) {
    params = "0,1";
  }

  const keywords = params.split(",");

  let url = process.env.REACT_APP_API_URL;
  if (url === undefined) {
      url = "http://localhost:5051";
  }

  const navigate = useNavigate();

  useEffect(() => {
    const fetchMovies = async () => {
      setLoading(true);
      try {
        const params = keywords[0] + "," + keywords[1];
        const response = await fetch(url + `/api/movie/?tags=${params}`);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const data = await response.json();
        setMovies(data); // Assuming the API returns an array of movie metadata
      } catch (err) {
        setError(err.message);
      }
      finally {
        setLoading(false);
      }
    };

    fetchMovies();
  }, []);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (error) {
    return <div className="error">Error: {error}</div>;
  }

  // Load more movies on button click
  const loadMoreMovies = () => {
    setVisibleMovies(visibleMovies + 5);
  };
  
  const back = () => navigate("/");

  const toggleProviders = (movieId) => {
    setShowProviders(prevState => ({
      ...prevState,
      [movieId]: !prevState[movieId] // Toggle visibility for the specific movie
    }));
  };

  return (
    <div>
      <h2>Recommended Movies:</h2>
      <div className="movie-collage">
        {movies.length > 0 ? (
          movies.slice(0, visibleMovies).map((movie) => (
            <div key={movie.id} className="movie-item">
                {/* Trailer */}
                <Trailer movie={movie} />
              {/* Watch Button */}
              <button onClick={() => toggleProviders(movie.id)}>
                  Links
              </button>

              {/* Display Provider Links */}
              {showProviders[movie.id] && (
                <div className="provider-links">
                  {movie.links.filter(link => link.label === "Provider").map((link) => {
                    const url = new URL(link.url); // Create a URL object to extract hostname
                    return (
                      <div key={link.url}>
                        <a href={link.url} target="_blank" rel="noopener noreferrer">{url.hostname}</a> {/* Display hostname */}
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          ))
        ) : (
          <p>No movies found.</p>
        )}
      </div>

      <div className="movie-collage">
          {visibleMovies < movies.length && (
            <button onClick={loadMoreMovies}>Load More</button>
          )}
          <button onClick={back}>Start Over</button>
      </div>
    </div>
  );
};

export default Result;
