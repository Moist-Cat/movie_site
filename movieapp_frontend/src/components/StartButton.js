import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import './StartButton.css'

const StartButton = ({ onStart }) => {
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showProviders, setShowProviders] = useState(false);

  let url = process.env.REACT_APP_API_URL;
  if (url === undefined) {
      url = "http://localhost:5051";
  }

  useEffect(() => {
    const fetchMovies = async () => {
      setLoading(true);
      try {
        const response_id = await fetch(url + `/api/tag/name/netflix/`);
        const tag_data = await response_id.json();
        const response = await fetch(url + `/api/movie/?tags=` +  tag_data.id  + `&limit=10`);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const data = await response.json();
        setMovies(data); // Assuming the API returns an array of movie metadata
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchMovies();
  }, []);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  const toggleProviders = (movieId) => {
    setShowProviders(prevState => ({
      ...prevState,
      [movieId]: !prevState[movieId] // Toggle visibility for the specific movie
    }));
  };


  return (
      <div>
          <div>
            <h1>Welcome to Movie Recommender!</h1>
            <button onClick={onStart}>Begin</button>
          </div>
          <div>
              <h2>TOP Netflix Films</h2>
              <div className="movie-collage">
                {movies.length > 0 ? (
                  movies.slice(0, 5).map((movie) => (
                    <div key={movie.id} className="movie-item">
                      <Link to={`/movie/${movie.id}`}>
                        <img src={movie.links[0].url} alt={movie.title} />
                      </Link>
                      <p>{movie.title} ({movie.release_year})</p>
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
          </div>
      </div>
  );
};

export default StartButton;

