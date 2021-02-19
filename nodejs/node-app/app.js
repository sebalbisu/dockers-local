'use strict';
const http = require('http');
const server = http.createServer(function (req, res) {
    res.writeHead(200, {'content-type': 'text/plain'});
    res.end('Hola Mundo');
    console.log("hola mundo");
});
server.listen(8000);
console.log("listening at port 8000...");