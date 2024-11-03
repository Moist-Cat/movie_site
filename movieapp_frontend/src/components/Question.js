import React from 'react';

const Question = ({ question, onNext }) => {
  const handleSelection = (keyword) => {
    onNext([keyword]);
  };
  return (
    <div>
      <h2>{question.text}</h2>
      <div>
        {question.keywords.map((keyword) => (
          <button key={keyword["name"]} onClick={() => handleSelection(keyword["param"])}>
            {keyword["name"]}
          </button>
        ))}
      </div>
    </div>
  );
};

export default Question;

