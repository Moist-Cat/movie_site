// Header.js
import React from 'react';
import logo from '../logo.jpeg';
import './Header.css';

const Header = () => (
  <header className="header">
    <a href="/" className="title"><img src={logo} alt="Logo" className="logo" /></a>
  </header>
);

export default Header;
