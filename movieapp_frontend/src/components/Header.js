// Header.js
import React from 'react';
import logo from '../logo.jpeg';
import './Header.css';

const Header = () => (
  <header className="header">
    <a href="/" className="title"><img src={logo} alt="Logo" className="logo" /></a>
    <h1>
      <a href="/" className="title">Movie Recommender</a>
    </h1>
  </header>
);

export default Header;
