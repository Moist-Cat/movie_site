import React, { useState, useEffect } from 'react';
import { RouterProvider, createBrowserRouter } from 'react-router-dom';
import MoviePage from './components/MoviePage';
import Root from './components/Root';
import Result from './components/Result';
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
        },
        {
            path: "/search",
            element: <Result />,
        },
    ]);

    return (
        <div className="App">
            <Header />
            <RouterProvider router={router} />
        </div>
    );
}

export default App;

