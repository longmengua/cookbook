const fs = require('fs');
const path = require('path');

/**
 *
 * */
const moduleName = 'About';
const templateName = 'Template';

const writePath = path.resolve(`_generation/${moduleName}`);
const readPath = path.resolve(`_generation/${templateName}`);

fs.mkdirSync(writePath, { recursive: true });
["index.tsx", "index.sass", "index_c.css"].forEach((fileName, index, arr)=>{
	fs.writeFileSync(path.resolve(writePath, fileName), fs.readFileSync(path.resolve(readPath, fileName), 'utf8').replace(new RegExp(templateName,"gm"), moduleName), {flag: "w+"});
});