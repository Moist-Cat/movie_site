import React, { useEffect, useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import './Result.css';

const Result = () => {
  const [movies, setMovies] = useState([]);
  const [trailer, setTrailer] = useState(null);
  const [trailer_id, setTrailerId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [showProviders, setShowProviders] = useState(false);
  const [error, setError] = useState(null);
  const [loadingTrailer, setLoadingTrailer] = useState(false);
  const [trailerError, setTrailerError] = useState(null);
  const [visibleMovies, setVisibleMovies] = useState(3);

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

  const loadTrailer = async (movieId) => {
    if (trailer) {
      setTrailer(null);
      if (trailer_id === movieId) {
          return;
      }
    }
    setTrailerId(movieId);
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

  // Load more movies on button click
  const loadMoreMovies = () => {
    setVisibleMovies(visibleMovies + 3);
  };
  
  const setLoadingText = (loadingTrailer, movie_id, trailer, trailer_id) => {
      if (loadingTrailer && movie_id === trailer_id) {
        return 'Loading Trailer...';
      }
      else {
        if (trailer && trailer_id == movie_id) {
          return 'Close Trailer';
        }
        else {
          return 'Load trailer';
        }
      }
  }

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
                { (trailer && movie.id === trailer.id) ? (
                  <div className="movie-media-item">
                    <video
                        controls
                        autoplay=""
                        name="media"
                        className="movie-media-item"
                        onClick={(e) => {
                          if (document.pictureInPictureEnabled) {
                          e.target.requestPictureInPicture();
                          }
                        }}
                    >
                      <source src={trailer.url} type="video/mp4" className="movie-media-item" />
                    </video>
                  </div>
                ) : (
                  <Link to={`/movie/${movie.id}`}>
                    <img src={movie.links[0].url} alt={movie.title} />
                  </Link>
                )}
              <p>{movie.title} ({movie.release_year})</p>
              <div className="movie-media-item">
                <button onClick={() => loadTrailer(movie.id)} disabled={loadingTrailer}>
                  {setLoadingText(loadingTrailer, trailer_id, trailer, movie.id)}
                </button>
              </div>
              {/* Watch Button */}
              <button onClick={() => toggleProviders(movie.id)}>
                Watch
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
