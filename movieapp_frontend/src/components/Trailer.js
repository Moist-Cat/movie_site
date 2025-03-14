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
        if (trailerError) {
             return trailerError;
        }
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

    const loadTrailer = async (movie) => {
      if (trailer) {
        setTrailer(null);
        if (trailer_id === movie.id) {
            return;
        }
      }
      setTrailerId(movie.id);
      setLoadingTrailer(true);

      let code = null;
      for (const link of movie.links) {
        if (link.label === "Trailer") {
            for (const chunk of link.url.split("/")) {
                code = chunk;
            };
        }
      }

      if (code) {
          setTrailer({"code": code, "id": movie.id});
      }
      else {
         setTrailerError("No trailer available!");
      }

      setLoadingTrailer(false);
    };

    return (
        <div>
            { (trailer && movie.id === trailer.id) ? (
              <div className="movie-media-item">
                <iframe src={`https://www.youtube.com/embed/${trailer.code}`} title="YouTube video player" frameBorder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerPolicy="strict-origin-when-cross-origin" allowFullScreen></iframe>
              </div>
            ) : (
              <Link to={`/movie/${movie.id}`}>
                <img src={movie.links[0].url} alt={movie.title} />
              </Link>
            )}
          <p>{movie.title} ({movie.release_year})</p>
          <div className="movie-media-item">
            <button onClick={() => loadTrailer(movie)} disabled={loadingTrailer}>
              {setLoadingText(loadingTrailer, trailer_id, trailer, movie.id)}
            </button>
          </div>
       </div>
   );
};

export default Trailer
