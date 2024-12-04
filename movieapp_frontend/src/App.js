import React, { useState, useEffect } from 'react';
import { RouterProvider, createBrowserRouter } from 'react-router-dom';
import MoviePage from './components/MoviePage';
import Root from './components/Root';
import Header from './components/Header';
import './styles.css';

const App = () => {
    const router = createBrowserRouter([
        {
            path: "/",
            element: <Root />,
        },
        {
            path: "/movie/:id",
            element: <MoviePage />,
        }
    ]);

    return (
        <div className="App">
            <Header />
            <RouterProvider router={router} />
        </div>
    );
}

export default App;

