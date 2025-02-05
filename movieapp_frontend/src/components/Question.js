import React from 'react';

function capitalize(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

const Question = ({ question, onNext }) => {
  const handleSelection = (keyword) => {
    onNext([keyword]);
  };
  return (
    <div>
      <h2>{question.text}</h2>
      <div style={{"gap": "15px", "display": "flex", "justify-content": "center"}}>
        {question.keywords.map((keyword) => (
          <button key={keyword["name"]} onClick={() => handleSelection(keyword["param"])}>
            {capitalize(keyword["name"])}
          </button>
        ))}
      </div>
    </div>
  );
};

export default Question;

