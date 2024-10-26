import React from 'react';

const StartButton = ({ onStart }) => (
  <div>
    <h1>Welcome to Movie Recommender!</h1>
    <button onClick={onStart}>Start</button>
  </div>
);

export default StartButton;

