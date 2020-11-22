const fs = require('fs');
const path = require('path');

/**
 *
 * */
const fileName = "translation.json";
const outcomeName = "outcome.json";

const writePath = path.resolve(`_revertTranslate/dist`);

const readPath = path.resolve(`_revertTranslate/src`);

fs.mkdirSync(writePath, { recursive: true });

const data = JSON.parse(fs.readFileSync(path.resolve(readPath, fileName), 'utf8'));
const outcome = JSON.parse(fs.readFileSync(path.resolve(readPath, outcomeName), 'utf8'));

console.log(data, outcome);

let i = 0;
for (let key in data){
	data[key] = outcome[i]
	i++;
}

console.log(data);

fs.writeFileSync(path.resolve(writePath, fileName), JSON.stringify(data), {flag: "w+"});