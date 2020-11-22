import express, { Application, Response, Request, NextFunction } from 'express';
import fs, {ReadStream} from 'fs';
import path from 'path';
import mongoose from "mongoose";
import Profile from "./repository/Profile";

const initDB = () => {
	const uri = "mongodb+srv://admin:admin@cluster0.74fjw.gcp.mongodb.net/demo?retryWrites=true&w=majority";

	mongoose.connect(uri, {useNewUrlParser: true, useUnifiedTopology: true})
		.then(r => r);

	const db = mongoose.connection;

	db.on('error', console.error.bind(console, 'connection error:'));
	db.once('open', function() {
		console.log("we're connected!")
	});
};

const app: Application = express();
const port: number = 8000;

initDB();

app.listen(port, function () {
	console.log('App is listening ' + port);
});

/**
 * root path
 * */
app.get('/', (req: Request, res: Response) => {
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

Profile(app, mongoose);