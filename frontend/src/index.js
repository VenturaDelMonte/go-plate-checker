import React from "react";
import ReactDOM from "react-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import AppRouter from './routes'
import './custom.css'
ReactDOM.render(
    <AppRouter />,
    document.getElementById('app')
);
