import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

const StartButton = ({ onStart }) => {
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  let url = process.env.REACT_APP_API_URL;
  if (url === undefined) {
      url = "http://localhost:5051";
  }

  useEffect(() => {
    const fetchMovies = async () => {
      setLoading(true);
      try {
        // XXX fixed ID
        const response_id = await fetch(url + `/api/tag/name/netflix`);
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


  return (
      <div>
          <div>
            <h1>Welcome to Movie Recommender!</h1>
            <button onClick={onStart}>Start</button>
          </div>
          <div>
              <h2>TOP Netflix Films</h2>
              <ul>
                {movies.length > 0 ? (
                  movies.map((movie) => (
                    <li key={movie.id} id={movie.id}>
                      <Link to={`/movie/${movie.id}`}>{movie.title} ({movie.release_year})</Link>
                    </li>
                  ))
                ) : (
                  <li>No movies found.</li>
                )}
              </ul>
          </div>
      </div>
  );
};

export default StartButton;

