import {Request, Response, NextFunction, Application,} from "express";
import {Mongoose} from "mongoose";
import { User, UserModel } from "../../model/User";

const path = "/Profile";

const Profile = (app: Application, mongoose: Mongoose) => {
	app.get(path, (req: Request, response: Response, next: NextFunction) => {
		//todo: implement get method
		response.send(`Get request on ${req.baseUrl}${path}`);
	});

	app.post(path, async (req: Request, response: Response, next: NextFunction) => {
		try {
			console.log(req.body);
			// const body = req.body;
			// const email = body.email as string;
			// const firstName = body.firstName as string;
			// const lastName = body.lastName as string;
			// const user: User = await UserModel.create(new User(email, firstName, lastName));
			response.send(`Post request on ${req.baseUrl}${path} >> `);
		} catch (e) {
			response.send(`Post request on ${req.baseUrl}${path} >> ${e}`);
		}
	});

	app.put(path, (req: Request, response: Response, next: NextFunction) => {
		//todo: implement put method
		response.send(`Put request on ${req.baseUrl}${path} >> ${req.body}`);
	});

	app.delete(path, (req: Request, response: Response, next: NextFunction) => {
		//todo: implement delete method
		response.send(`Delete request on ${req.baseUrl}${path}`);
	});
};

export default Profile;