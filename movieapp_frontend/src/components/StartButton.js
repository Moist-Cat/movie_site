import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import './StartButton.css'

const StartButton = ({ onStart }) => {
  const [netflix, setNetflix] = useState([]);
  const [amazon, setAmazon] = useState([]);
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
        const net_response = await fetch(url + `/api/movie/list/netflix/?limit=10`);
        if (!net_response.ok) {
          throw new Error('Network response was not ok');
        }
        const net_json = await net_response.json();
        setNetflix(net_json);

        const amz_id = await fetch(url + `/api/tag/name/amazon/`);
        const amz_data = await amz_id.json();
        const amz_response = await fetch(url + `/api/movie/?tags=` +  amz_data.id  + `&limit=10`);
        if (!amz_response.ok) {
          throw new Error('Network response was not ok');
        }
        const amz_json = await amz_response.json();
        setAmazon(amz_json);

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
              <h2>TOP Netflix Picks</h2>
              <div className="movie-collage">
                {netflix.length > 0 ? (
                  netflix.slice(0, 5).map((movie) => (
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

              <h2>TOP Amazon Picks</h2>
              <div className="movie-collage">
                {amazon.length > 0 ? (
                  amazon.slice(0, 5).map((movie) => (
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

