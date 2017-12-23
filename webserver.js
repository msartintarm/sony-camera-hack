

const http = require("http");
const fs = require("fs");


const checkError = (response, e) => {
	if (e) {
		console.error(`Error found.`);
		console.error(e.message);
		response.write("Error!", () => {
			response.end();
		});
		return true;
	}
	return false;
};

const respondWithFile = (response, fileName, headers) => {
	fs.readFile(fileName, (err, file) => {
		if (checkError(response, err)) { return; }
		response.writeHead(200, headers);
		response.write(file, () => { response.end(); });
	});
};

const requestListener = (request, response) => {
	const url = request.url;
	console.log(`Handling request ${url}..`);
	if (url == "/") {
		respondWithFile(response, "index.html", {"Content-Type": "text/html"});
	} else if (url == "/css") {
		respondWithFile(response, "work/bundle.css", {"Content-Type": "text/css"});
	} else if (url == "/js") {
		respondWithFile(response, "work/bundle.js", {"Content-Type": "text/javascript"});
	} else if (url == "/jslib") {
		respondWithFile(response, "work/bundle-lib.js", {"Content-Type": "text/javascript"});
	} else {
		console.error(`Uh oh.. ${url} not found..`);
		response.writeHead(404);
		response.end();
	}
};

const webserver = http.createServer(requestListener);

process.on("SIGINT", () => {
	webserver.close()
	console.log("Server terminated. See ya!");
	console.log("");
});

console.log("");
console.log("Compilation complete. Starting server..");
webserver.listen(4000);
