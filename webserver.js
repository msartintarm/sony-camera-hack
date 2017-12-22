const http = require("http");
const fs = require("fs");


const response = (req, res) => {
	fs.readFile("index.html", (err, file) => {
		if (err) {
			return {code: 404, message: "Error"};
		} else {
			res.writeHead(200, {"Content-Type": "text/html" });
			res.write(file);
		}
		res.end();
	});
};

const webserver = http.createServer(response);

webserver.listen(4000);
