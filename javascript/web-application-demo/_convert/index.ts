const fs = require('fs');
const path = require('path');

/**
 *
 * */
const moduleName = 'Dist';
const writePath = path.resolve(`_convert/${moduleName}`);

const templateName = 'Template';
const readPath = path.resolve(`_convert/${templateName}`);

fs.mkdirSync(writePath, { recursive: true });
fs.readdir(path.resolve(readPath), (err, files) => {
	files.forEach(fileName => {
		if(!new RegExp("js?x","g").test(fileName))return;
		const source = fs.readFileSync(path.resolve(readPath, fileName), 'utf8');
		const arr = source.split(/<Typography[\w ={}'.()>;]*[>]+/g);
		const data = arr.map(e=>e.substr(0, e.indexOf("</Typography>"))).filter(value => /^[\w\s.]+$/g.test(value));
		let json = {};
		let result = source;

		data.map((value, index)=> {
			const key = `${fileName.split(".jsx")[0]}.Text.${index + 1}`;
			result = result.replace(`>${value}<`, `>{i18next.t('${key}')}<`);
			json[key] = value;
		});

		fs.writeFileSync(path.resolve(writePath, fileName), `import {i18n as i18next} from "i18next";\n${result}\n//${JSON.stringify(json)}`, {flag: "w+"});
	});
});
// ["header.jsx"].forEach((fileName)=>{
// 	const source = fs.readFileSync(path.resolve(readPath, fileName), 'utf8');
// 	const arr = source.split(/<Typography[\w ={}'.()>;]*[>]+/g);
// 	const data = arr.map(e=>e.substr(0, e.indexOf("</Typography>"))).filter(value => /^[\w\s.]+$/g.test(value));
// 	let json = {};
// 	let result = source;
//
// 	data.map((value, index)=> {
// 		const key = `${moduleName}.Text.${index + 1}`;
// 		result = result.replace(value, `{i18next.t("${key}")}`);
// 		json[key] = value;
// 	});
//
// 	fs.writeFileSync(path.resolve(writePath, fileName), `${result}\n//${JSON.stringify(json)}`, {flag: "w+"});
// });