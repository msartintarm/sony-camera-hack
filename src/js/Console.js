import * as React from 'react';

class Console extends React.Component {

	constructor(props) {
		super(props);
		this.cameraUrl = "http://192.168.122.1:8080/sony/camera";
		this.state = { logText: "Hello" };
	}

	sendTakePicture = () => {
		console.log("Sending picture");

		const message = '{"method": "getShootMode", "id": 1, "version": "1.0"}';

		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				console.log(xhr.responseText);
				const response = JSON.parse(xhr.responseText);

				this.setState({ logText: response.result });

				console.log(response.id, response.result);
			}
		};
		xhr.open('POST', this.cameraUrl, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(message);
	};

	render () {
		return (
				<div>
				<div className="container">
				<p>Console.</p>
				<input type={"button"}
			onClick={this.sendTakePicture}
			value={"Take Picture"}
				/>
				<input type={"textarea"} readOnly
			value={this.state.logText}
				/>
				</div>
				</div>
		);
	}
}

export default Console
