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
	data = data.filter(value => 
		/^[\w\s.{'",}()]+$/g.test(value));
	// Data = data.filter(value => !/asset\./g.test(value));
	// Data = data.filter(value => !/option\./g.test(value));
	// Data = data.filter(value => !/{ inputAdornment }/g.test(value));
	// Data = data.filter(value => !/{ option }/g.test(value));
	data = data.filter(value => 
		!/{ screen }/g.test(value));
	// Data = data.filter(value => !/{ address }/g.test(value));
	// Data = data.filter(value => !/{ e.blockNumber }/g.test(value));
	// Data = data.filter(value => !/{ parseFloat(asset.tokenBalance).toFixed(2) }/g.test(value));
	// Data = data.filter(value => !/{ this.lender(asset.current) }/g.test(value));
	// Data = data.filter(value => !/{ rewardPool.name }/g.test(value));
	// Data = data.filter(value => !/{ pool.name }/g.test(value));
	data = data.filter(value => 
		!/{address}/g.test(value));
	data = data.filter(value => 
		!/this.votingMessage\(proposal\)/g.test(value));
	data = data.filter(value => 
		!/this.formatVotes\(proposal.myVotes\)/g.test(value));
	data = data.filter(value => 
		!/{ asset.symbol }/g.test(value));
	data = data.filter(value => 
		!/{ pool.name }/g.test(value));
	data = data.filter(value => 
		!/{ address }/g.test(value));
	data = data.filter(value => 
		!/asset.claimableBalance/g.test(value));
	data = data.filter(value => 
		!/rewardPool.name/g.test(value));
	data = data.filter(value => 
		!/contract.name/g.test(value));
	data = data.filter(value => 
		!/option.symbol/g.test(value));
	data = data.filter(value => 
		!/quoteContract/g.test(value));
	data = data.filter(value => 
		!/quote.amount/g.test(value));
	data = data.filter(value => 
		!/option.symbol/g.test(value));
	data = data.filter(value => 
		!/contract.name/g.test(value));
	data = data.filter(value => 
		!/contract.coverAmount/g.test(value));
	// Data = data.filter(value => !//g.test(value));
	// Data = data.filter(value => !//g.test(value));
	// Data = data.filter(value => !//g.test(value));
	// Data = data.filter(value => !//g.test(value));

	return data;
}

function f(files) {
	let jsons = {};
	files.forEach(fileName => {
		if (!new RegExp("js?x","g")
			.test(fileName.name)) return;
		const path = fileName.path.replace(templateName, moduleName);
		const source = fs.readFileSync(fileName.path, 'utf8');
		const arr = source.split(/<Typography[\w ={}'.()>;$`]*[>]+/g);
		let result = source;
		let json = {};
		let data = arr.map(e=>
			e.substr(0, e.indexOf("</Typography>")));

		data = customFilter(data);
		data.map((value, index)=> {
			let names;
			let key;
			try {
				names = fileName.path.split(templateName + "/")[1].split(/\//g);
				key = `${names[0]}.${names[1].replace(".jsx", "")}-Text-${index + 1}`;
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