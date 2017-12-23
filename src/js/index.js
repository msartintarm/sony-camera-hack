import Component from './Component';

import ReactDOM from 'react-dom';

import { onTick } from './EventHandler';

class App extends Component {

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

ReactDOM.render(<App />, document.body.firstElementChild);
