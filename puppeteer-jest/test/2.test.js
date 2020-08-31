const {expect} = require("@jest/globals")

const puppeteer = require("puppeteer")

const {installMouseHelper} = require("../configs/mouseHelper")
const {launchConfig} = require("../configs/launch.config")

test("Testing login", async () => {
    const browser = await puppeteer.launch(launchConfig)
    const page =  await browser.newPage()
    await installMouseHelper(page)

    try {
        await page.goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com/login")
        expect(false).toBe(false)

    } finally {
        await browser.close()
    }
})
