// const {expect} = require('@jest/globals');
//
// function sum(a, b) {
// 	return a + b;
// }
//
// test('adds 1 + 2 to equal 3', () => {
// 	expect(sum(1, 2)).toBe(3);
// });

const {beforeAll, describe, expect, it} = require('@jest/globals');

describe('Google', () => {
	beforeAll(async () => {
		const page = await browser.newPage();
		await page.goto('https://google.com');
	});

	it('should open a new page', async () => {
		await page.goto('https://google.com');
		await expect(page.title()).resolves.toMatch('Google');
	});
});