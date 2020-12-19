import { model, Schema, Model, Document } from 'mongoose';

class User extends Document {
    private email: string;
    private firstName: string;
    private lastName: string;


    constructor(email?: string, firstName?: string, lastName?: string) {
    	super();
    	this.email = email || "";
    	this.firstName = firstName || "";
    	this.lastName = lastName || "";
    }
}

const UserSchema: Schema = new Schema({
	email    : { type: String, required: true },
	firstName: { type: String, required: true },
	lastName : { type: String, required: true }
});

const UserModel: Model<User> = model('User', UserSchema);

export {User, UserModel, UserSchema};