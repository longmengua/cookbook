const {expect} = require("@jest/globals")

const puppeteer = require("puppeteer")
const {installMouseHelper} = require("../configs/mouseHelper")
const {launchConfig} = require("../configs/launch.config")


test("Testing navigation bars.", async () => {
    const browser = await puppeteer.launch(launchConfig)
    const page =  await browser.newPage()
    await installMouseHelper(page)
    await page.setViewport({width:1440,height:800})

    try {
        await page.goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com", {timeout: 10000})
        const logUrls = []

        //there should be 5 buttons in navigation bar.
        let elements = await page.mainFrame().$$(".single-icon")
        expect(elements).toHaveLength(5)

        //iterate each one but 2th, cause 2th is not a navigation link.
        for(let i = 1; i <= elements.length; i++){
            if(i === 3) continue
            logUrls.push(await page.evaluate("location.href"))
            let e = await page.mainFrame().waitForSelector(".single-icon:nth-child(" + i + ")")
            await e.click()
            await page.waitForNavigation()
            logUrls.push(await page.evaluate("location.href"))
            expect(logUrls.pop()).not.toBe(logUrls.pop())
            await page.goBack({waitUntil: "domcontentloaded"})
        }
    } finally {
        await browser.close()
    }
}, 60*1000)
