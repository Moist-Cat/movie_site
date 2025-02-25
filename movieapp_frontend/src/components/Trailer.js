import { Link, useSearchParams, useNavigate } from 'react-router-dom';
import React, { useEffect, useState } from 'react';

const Trailer = ({movie}) => {
    const [movies, setMovies] = useState([]);
    const [trailer, setTrailer] = useState(null);
    const [trailer_id, setTrailerId] = useState(null);
    const [showProviders, setShowProviders] = useState(false);
    const [loadingTrailer, setLoadingTrailer] = useState(false);
    const [trailerError, setTrailerError] = useState(null);

    let url = process.env.REACT_APP_API_URL;
    if (url === undefined) {
        url = "http://localhost:5051";
    }

    const setLoadingText = (loadingTrailer, movie_id, trailer, trailer_id) => {
        if (loadingTrailer && movie_id === trailer_id) {
          return 'Loading Trailer...';
        }
        else {
          if (trailer && trailer_id == movie_id) {
            return 'Close Trailer';
          }
          else {
            return 'Watch trailer';
          }
        }
    }

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

    return (
        <div>
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
       </div>
   );
};

export default Trailer
