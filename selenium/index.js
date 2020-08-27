const {Builder, By, Key, until} = require('selenium-webdriver');
//account: hucc / password: 7FytdQVj
(async function example() {
	let driver = await new Builder().forBrowser('chrome').build();
	const delay = ms => new Promise(res => setTimeout(res, ms));
	try {
		//driver.get("https://username:password@somewebsite.com/")
		await driver.get("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
	} finally {
		await delay(10000);
		await driver.quit();
	}
})();