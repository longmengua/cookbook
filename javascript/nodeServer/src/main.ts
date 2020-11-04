import express, { Application } from 'express';
import fs, {ReadStream} from 'fs';
import path from 'path';

const app: Application = express();

app.listen(3000, function () {
	console.log('App is listening on port 3000!');
});

/**
 * root path
 * */
app.get('/', function (req, res) {
	res.send('Hello World!');
});

/**
 * this is for mock server.
 * */
app.get('/json/:name', function (req, res, next) {
	next();
}, function (req, res, next) {
	next();
}, function (req, res, next) {
	const sourcePath: string = path.resolve('src/repository/');
	const name = req.params['name'];
	const param = req.query['p'];
	const stream: ReadStream = fs.createReadStream(path.resolve(sourcePath, `${name}.json`));
	stream.pipe(res);
});