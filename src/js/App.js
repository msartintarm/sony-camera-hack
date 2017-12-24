import * as React from 'react';
import { onTick } from './EventHandler';

/** Setup the app. Takes care of registering event handlers. */
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
		return (<div className="container">
				<p>Welcome to the camera app.</p>
				</div>);
	}
}

export default App
