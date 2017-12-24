import * as React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import Console from './Console';

ReactDOM.render(<App />, document.getElementById("app_container"));
ReactDOM.render(<Console />, document.getElementById("console_container"));
