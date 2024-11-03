import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

const Result = ({ keywords, onRestart, tags, genres }) => {
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchMovies = async () => {
      setLoading(true);
      try {
        const params = keywords[0] + "," + keywords[1] + "&" + keywords[2];
        const response = await fetch(`api/movie?tags=${params}`);
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
  }, [keywords]);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (error) {
    return <div className="error">Error: {error}</div>;
  }

  return (
    <div>
      <h2>Recommended Movies:</h2>
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
      <button onClick={onRestart}>Start Over</button>
    </div>
  );
};

export default Result;
