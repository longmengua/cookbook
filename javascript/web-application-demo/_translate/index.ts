const fs = require('fs');
const path = require('path');

/**
 *
 * */
const fileName = "translation.json";

const moduleName = 'dist';
const writePath = path.resolve(`_translate/${moduleName}`);

const templateName = 'src';
const readPath = path.resolve(`_translate/${templateName}`);

fs.mkdirSync(writePath, { recursive: true });

const data = fs.readFileSync(path.resolve(readPath, fileName), 'utf8');
const json = JSON.parse(data);
let toReturn = [];
for (let key in json){
	toReturn.push(json[key]);
}

fs.writeFileSync(path.resolve(writePath, fileName), JSON.stringify(toReturn), {flag: "w+"});