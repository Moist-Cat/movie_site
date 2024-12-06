import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import './Result.css';

const Result = ({ keywords, onRestart, genres }) => {
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [visibleMovies, setVisibleMovies] = useState(3);

  let url = process.env.REACT_APP_API_URL;
  if (url === undefined) {
      url = "http://localhost:5051";
  }

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

  // Load more movies on button click
  const loadMoreMovies = () => {
    setVisibleMovies(visibleMovies + 3);
  };

  const back = btoa(keywords[0] + "," + keywords[1]);

  return (
    <div>
      <h2>Recommended Movies:</h2>
      <div className="movie-collage">
        {movies.length > 0 ? (
          movies.slice(0, visibleMovies).map((movie) => (
            <div key={movie.id} className="movie-item">
              <Link to={`/movie/${movie.id}`}>
                <img src={movie.links[0].url} alt={movie.title} />
              </Link>
              <p>{movie.title}</p>
            </div>
          ))
        ) : (
          <p>No movies found.</p>
        )}
      </div>

      {visibleMovies < movies.length && (
        <button onClick={loadMoreMovies}>Load More</button>
      )}
      
      <button onClick={onRestart}>Start Over</button>
    </div>
  );
};

export default Result;
