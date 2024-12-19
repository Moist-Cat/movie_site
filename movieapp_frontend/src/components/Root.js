import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";

import StartButton from './StartButton';
import Question from './Question';
import Result from './Result';


const questions = [
  { id: 1, text: 'Select an streaming service', keywords: null },
  { id: 2, text: 'What mood or genre are you in the mood for?', keywords: null },
];

const Root = () => {
    const [step, setStep] = useState(0);
    const [selectedKeywords, setSelectedKeywords] = useState([]);

    const [tags, setTags] = useState(null);
    const [genres, setGenres] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const navigate = useNavigate();

    let url = process.env.REACT_APP_API_URL;
    if (url === undefined) {
        url = "http://localhost:5051";
    }

    useEffect(() => {
        const fetchData = async () => {
            try {
                setLoading(true);
                const response1 = fetch(url + '/api/tag/?category=provider&limit=10');
                const response2 = fetch(url + '/api/tag/?category=genre&limit=10');

                const [res1, res2] = await Promise.all([response1, response2]);

                if (!res1.ok || !res2.ok) {
                    throw new Error('Network response was not ok');
                }

                const tags = await res1.json();
                const genres = await res2.json();

                setTags(tags);
                setGenres(genres);
            } catch (err) {
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error}</div>;

    let tag_names = [];
    let genre_names = [];

    for (let i = 0; i < tags.length; i++) {
        tag_names.push(tags[i]);
        tags[i].param = tags[i]["id"];
    }
    for (let i = 0; i < genres.length; i++) {
        genre_names.push(genres[i]);
        genres[i].param = genres[i]["id"];
    }

    questions[0].keywords = tag_names;
    questions[1].keywords = genre_names;

    const handleStart = () => setStep(1);
  
    const handleNext = (keywords) => {
        setSelectedKeywords([...selectedKeywords, ...keywords]);
        setStep(step + 1);
        if (step >= questions.length) {
            navigate("search?q=" + selectedKeywords.concat(keywords).join(","));
        }
    };

    const handleRestart = () => {
        setStep(0);
        setSelectedKeywords([]);
    };

    const last = () => navigate("/search");

    const renderContent = () => {
        if (step === 0) {
              return <StartButton onStart={handleStart} />;
        }
        else if (step <= questions.length) {
            return (
                <Question
                  question={questions[step - 1]}
                  onNext={handleNext}
                />
            );
        }
    };
    return renderContent();
};

export default Root;
