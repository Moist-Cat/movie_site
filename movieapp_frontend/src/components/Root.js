import React, { useState, useEffect } from 'react';
import { useNavigate } from "react-router-dom";

import StartButton from './StartButton';
import Question from './Question';
import { fetchData } from '../api';


const questions = [
  { id: 1, text: 'Select a streaming service', keywords: null, endpoint: null},
  { 
      id: 2,
      text: 'What mood or genre are you in the mood for?',
      keywords: null,
      endpoint: (provider_id) => `/api/tag/?category=genre&limit=12&containing=${provider_id}`
  }
];

const Root = () => {
    const [step, setStep] = useState(0);
    const [selectedKeywords, setSelectedKeywords] = useState([]);

    const [tags, setTags] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const navigate = useNavigate();

    useEffect(() => {
        const fetchTags = async () => {
            try {
                setLoading(true);
                const { data } = await fetchData('/api/tag/?category=provider&limit=10');

                setTags(data);
            } catch (err) {
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };

        fetchTags();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error}</div>;

    let tag_names = [];

    for (let i = 0; i < tags.length; i++) {
        tag_names.push(tags[i]);
        tags[i].param = tags[i]["id"];
    }

    questions[0].keywords = tag_names;
    questions[1].keywords = null;

    const handleStart = () => setStep(1);
  
    const handleNext = (keywords) => {
        setStep(step + 1);
        if (step >= questions.length) {
            navigate("search?q=" + selectedKeywords.concat(keywords).join(","));
        }
        setSelectedKeywords([...selectedKeywords, ...keywords]);
    };

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
