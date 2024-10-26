import React, { useState, useEffect } from 'react';
import Header from './components/Header';
import StartButton from './components/StartButton';
import Question from './components/Question';
import Result from './components/Result';
import './styles.css';

const questions = [
  { id: 1, text: 'What mood or genre are you in the mood for?', keywords: null },
  {
      id: 2, text: 'Do you prefer recent releases or are you open to older classics?',
      keywords: [{"name":"Recent", "index": 0}, {"name": "90s", "index": 1}, {"name": "Don't care", "index": 2}] 
  },
  { id: 2, text: 'Are you interested in specific actors, directors, or themes?', keywords: null },
];

const App = () => {
    const [step, setStep] = useState(0);
    const [selectedKeywords, setSelectedKeywords] = useState([]);

    const [tags, setTags] = useState(null);
    const [genres, setGenres] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                setLoading(true);
                const response1 = fetch('tag/');
                const response2 = fetch('/tag/?category=genre&limit=10');

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
        tags[i].index = i;
    }
    for (let i = 0; i < genres.length; i++) {
        genre_names.push(genres[i]);
        genres[i].index = i;
    }

    questions[0].keywords = genre_names;
    questions[2].keywords = tag_names;

    const handleStart = () => setStep(1);
  
    const handleNext = (keywords) => {
        setSelectedKeywords([...selectedKeywords, ...keywords]);
        setStep(step + 1);
    };

    const handleRestart = () => {
        setStep(0);
        setSelectedKeywords([]);
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
        else {
            return <Result keywords={selectedKeywords} onRestart={handleRestart} tags={tags} genres={genres}/>;
        }
    };

    return (
        <div className="App">
            <Header /> {/* Add the header */}
          {renderContent()}
        </div>
    );
}

export default App;

