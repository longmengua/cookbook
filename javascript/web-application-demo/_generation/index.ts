const fs = require('fs');
const path = require('path');

/**
 *
 * */
const moduleName = 'Arrow';
const writePath = path.resolve(`src/Util/${moduleName}`);

const templateName = 'Template';
const readPath = path.resolve(`_generation/${templateName}`);

fs.mkdirSync(writePath, { recursive: true });
["index.tsx", "index.sass", "index_c.css", "interface.ts"].forEach((fileName, index, arr)=>{
	fs.writeFileSync(path.resolve(writePath, fileName), fs.readFileSync(path.resolve(readPath, fileName), 'utf8').replace(new RegExp(templateName,"gm"), moduleName), {flag: "w+"});
});