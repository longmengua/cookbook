const {expect} = require("@jest/globals");

const puppeteer = require("puppeteer");

test("test case", async () => {
	const browser = await puppeteer.launch({
		// headless <boolean> Whether to run browser in headless mode,
		// false means not testing without launching up browser.
		headless: false,
		// Whether to auto-open a DevTools panel for each tab. If this option is true,
		// the headless option will be set false.
		// devtools: true,
		// Slows down Puppeteer operations by the specified amount of milliseconds.
		// Useful so that you can see what is going on.
		// Sets a consistent viewport for each page.
		// Defaults to an 800x600 viewport. null disables the default viewport.
		defaultViewport: null,
	});
	const page =  await browser.newPage();

	try {
		await page.goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");

		//todo: testing links under the div with header-extras class name.
		// const urlBeforeNavigate = await page.evaluate('location.href');
		// await page.click('.header-extras:nth-child(1)');
		// const urlAfterNavigate = await page.evaluate('location.href');

		expect(urlBeforeNavigate).toBe(urlAfterNavigate);

		// await page.click('input#firstName');
		// await page.type('input#firstName', ' ');
		// await page.click('input#lastName');
		// await page.type('input#lastName', 'Doe');
		// await page.click('input#password');
		// await page.type('input#password', '123456abc');
		// await page.click('input#confirmPassword');
		// await page.type('input#confirmPassword', '123456abc');
		// await page.click('input#email');
		// await page.type('input#email', 'john@email.com');
		// await page.click('input#firstName');

		// const invalidInput = await page.$eval('input.invalid', (input) => input);
		// expect(invalidInput).toBeDefined();
	} finally {
		await page.waitFor();
		await browser.close();
	}
});