import React, { useState, useEffect } from 'react';
import { fetchData } from '../api';

function capitalize(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

const fetchTags = async (question, lastParam) => {
    // If keywords are already present, return them
    if (question.keywords !== null) {
        return question.keywords;
    }

    // Fetch tags based on the last parameter
    const { data } = await fetchData(question.endpoint(lastParam));
    let tag_names = [];

    for (let i = 0; i < data.length; i++) {
        tag_names.push(data[i]);
        data[i].param = data[i]["id"];
    }

    // Update the question's keywords for future use
    question.keywords = tag_names;
    return tag_names;
};

const Question = ({ question, onNext }) => {
    const [lastParam, setLastParam] = useState(null);
    const [keywords, setKeywords] = useState([]);

    const handleSelection = (keyword) => {
        setLastParam(keyword);
        onNext([keyword]);
    };

    useEffect(() => {
        fetchTags(question, lastParam).then(setKeywords);
    }, [lastParam, question]); // Re-run when lastParam changes

    return (
        <div>
            <h2>{question.text}</h2>
            <div style={{ gap: "15px", display: "flex", justifyContent: "center", flexWrap: "wrap" }}>
                {keywords.map((keyword) => (
                    <button key={keyword["name"]} onClick={() => handleSelection(keyword["param"])}>
                        {capitalize(keyword["name"])}
                    </button>
                ))}
            </div>
        </div>
    );
};

export default Question;
