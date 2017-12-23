import * as React from 'react';

import ReactDOM from 'react-dom';

import { onTick } from './EventHandler';

class App extends React.Component {

	constructor () {
		super();
		this.state = { frameNum: 0 };
	}

	tick = () => {
		requestAnimationFrame(this.tick);
		this.setState({ frameNum: this.state.frameNum + 1 }, onTick);
	};

	componentDidMount () {
		requestAnimationFrame(this.tick);
	}

	render () {
		return (
<div>
	<div className="container">
				Welcome to the camera app.
	</div>
</div>
		);
	}
}

ReactDOM.render(<App />, document.getElementById("index_container"));
