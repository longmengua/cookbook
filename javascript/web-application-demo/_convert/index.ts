const fs = require('fs');
const path = require('path');

/**
 *
 * */
const moduleName = 'Dist';
const writePath = path.resolve(`_convert/${moduleName}`);

const templateName = 'components';
const readPath = path.resolve(`_convert/${templateName}`);

fs.mkdirSync(writePath, { recursive: true });

getFiles(path.resolve(readPath))
	.then(files=>
		f(files));

async function getFiles(path = "./") {
	const entries = await fs.readdirSync(path, { withFileTypes: true });

	// Get files within the current directory and add a path key to the file objects
	const files = entries
		.filter(file => 
			!file.isDirectory())
		.map(file => 
			({ ...file, path: `${path}/${file.name}` }));

	// Get folders within the current directory
	const folders = entries.filter(folder => 
		folder.isDirectory());

	for (const folder of folders)
		files.push(...await getFiles(`${path}/${folder.name}`));

	return files;
}

function customFilter(_data) {
	let data = _data;

	//vault
	data = data.filter(value => value != "");
	data = data.filter(value => !/asset\./g.test(value));
	data = data.filter(value => !/25%/g.test(value));
	data = data.filter(value => !/50%/g.test(value));
	data = data.filter(value => !/75%/g.test(value));
	data = data.filter(value => !/100%/g.test(value));
	data = data.filter(value => !/option\./g.test(value));
	data = data.filter(value => !/this\._getAPY/g.test(value));

	// data = _data.filter(value => !//g.test(value));

	return data;
}

function f(files) {
	let jsons = {};
	files.forEach(fileName => {
		if (!new RegExp("js?x","g")
			.test(fileName.name)) return;
		const path = fileName.path.replace(templateName, moduleName);
		const source = fs.readFileSync(fileName.path, 'utf8');

		const arr = source.match(/<Typography(.)*Typography>/g);
		let result = source;
		let json = {};
		let data = arr.map((e,i)=>{
			const from = e.indexOf(">")+1;
			const end = e.indexOf("<\/Typography>");
			const toReturn = e.substring( from, end);
			if (e.indexOf("classes.fees") > -1){
				console.log("debugger");
			}
			return  toReturn;
		});

		data = customFilter(data);
		data.map((value, index)=> {
			let names;
			let key;
			try {
				names = fileName.path.split(templateName + "/")[1].split(/\//g);
				key = `${names[0]}-${names[1].replace(".jsx", "")}-Text-${index + 1}`;
				result = result.replace(`>${value}<`, ` id="${key}" >{i18next.t('${key}')}<`);
				json[key] = value;
				jsons[key] = value;
			} catch (e) {
				console.log(e);
			}
		});

		 if (!fs.existsSync(path)){
		 	fs.mkdirSync(path.replace(`/${fileName.name}`, ""), { recursive: true });
		 }

		fs.writeFileSync(path, `//i18n => ${JSON.stringify(json)}\nimport i18next from "i18next";\n${result}`, {flag: "w+"});
	});
	const formatJSON = JSON.stringify(jsons)
		.replace(/{/, "{\n\040\040")
		.replace(/"}/, "\"\n}")
		.replace(/",/g, "\",\n\040\040");
	fs.writeFileSync(path.resolve(writePath, "en.json"), formatJSON, {flag: "w+"});
}