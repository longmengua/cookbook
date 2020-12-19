import mongoose from "mongoose";

(() => {
	const dbName = "demo";

	const uri = `mongodb+srv://admin:admin@cluster0.74fjw.gcp.mongodb.net/${dbName}?retryWrites=true&w=majority`;

	mongoose.connect(uri, {useNewUrlParser: true, useUnifiedTopology: true})
		.then(r => r);

	const db = mongoose.connection;

	db.on('error', console.error.bind(console, 'connection error:'));
	db.once('open', function() {
		console.log("we're connected!")
	});
})();