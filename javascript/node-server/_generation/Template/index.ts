// @ts-ignore
import mongoose from "mongoose";
import {Request, Response, NextFunction, } from "express";
// @ts-ignore
import app from "../../main";

const path = "/@path";

app.get(path, (req: Request, response: Response, next: NextFunction) => {
	//todo: implement get method 
	response.send(`Get request on ${req.baseUrl}${path}`);
});

app.post(path, (req: Request, response: Response, next: NextFunction) => {
	//todo: implement post method
	response.send(`Post request on ${req.baseUrl}${path}`);
});

app.put(path, (req: Request, response: Response, next: NextFunction) => {
	//todo: implement put method
	response.send(`Put request on ${req.baseUrl}${path}`);
});

app.delete(path, (req: Request, response: Response, next: NextFunction) => {
	//todo: implement delete method
	response.send(`Delete request on ${req.baseUrl}${path}`);
});