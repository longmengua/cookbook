const f = require('fs');
const path = require('path');

/**
 *
 * */
const folderName = "Profile";

const readPath = path.resolve(`_generation/Template`);
const writePath = path.resolve(`src/repository/${folderName}`);

f.mkdirSync(writePath, { recursive: true });

[ "index.ts" ].forEach((fileName, index, arr)=>{
	f.writeFileSync(
		path.resolve(writePath, fileName), 
		f.readFileSync(path.resolve(readPath, fileName), 'utf8')
			.replace("// @ts-ignore\n", "")
			.replace("@path", folderName),
		{flag: "w+"}
	);
});