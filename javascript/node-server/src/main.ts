import express, { Application, Response, Request, NextFunction } from 'express';
import fs, {ReadStream} from 'fs';
import path from 'path';
import mongoose from "mongoose";
import "./config/mongodb";
import Profile from "./controller/Profile";

const app: Application = express();
const port: number = 8000;

app.listen(port, function () {
	console.log('App is listening ' + port);
});

/**
 * root path
 * */
app.get('/', (req: Request, res: Response) => {
	console.log("test");
	res.send('Hello World!');
});

/**
 * this is for mock server.
 * */
app.get('/json/:name', (req: Request, res: Response, next: NextFunction) => {
	const sourcePath: string = path.resolve('src/json/');
	const name = req.params['name'];
	// const param = req.query['p'];
	const stream: ReadStream = fs.createReadStream(path.resolve(sourcePath, `${name}.json`));
	stream.pipe(res);
});

app.post('/todos', (req: Request, res) => {
	let data = '';
	req.on('data', chunk => {
		console.log(chunk);
		data += chunk;
	});

	req.on('end', () => {
		console.log(">>",data);
		res.send(data);
	})
});

Profile(app, mongoose);