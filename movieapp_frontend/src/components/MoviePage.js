import React, { useEffect, useState } from 'react';

const MoviePage = ({ match }) => {
  const [movie, setMovie] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const movieId = match.params.id; // Get the movie ID from the URL

  useEffect(() => {
    const fetchMovie = async () => {
      setLoading(true);
      try {
        const response = await fetch(`api/movie/${movieId}`); // Fetch details using the ID
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

  return ( 
    <div className="movie-details">
      {movie ? (
        <>
          <h2>{movie.title} ({movie.release_year})</h2>
          <p><strong>Keywords:</strong> {movie.tags.join(', ')}</p>
          {/* <p><strong>Summary:</strong> {movie.summary}</p> */}
          <p><strong>Rating:</strong> {movie.rating}</p>
        </>
      ) : (
        <div>No movie found.</div>
      )}
    </div>
  );
};

export default MoviePage;

