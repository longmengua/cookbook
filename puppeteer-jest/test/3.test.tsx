const puppeteer = require("puppeteer");
const {installMouseHelper} = require("../configs/mouseHelper");
const {launchConfig} = require("../configs/launch.config");
const {getTwID} = require("../lib/idGeneration");
import("expect-puppeteer");

// const fakeRandomData = {
//     id: "A201574155",//身分證
//     password: "a1234567",
// }

const fakeData = {
    id: "A201574155", // 身分證
    password: "a1234567",
};

test("Testing login", async () => {
    const browser = await puppeteer.launch(launchConfig);
    const page = await browser.newPage();
    await installMouseHelper(page);
    await page.setViewport(launchConfig.viewport);

    try {
        getTwID();
        console.log("open home page");
        await page.mainFrame().goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
        console.log("click member");
        await expect(page).toClick("a[href='https://hucc-demo.estiginto.com/member']");
        await page.waitForNavigation();
        console.log("valid URL");
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/login");
        console.log("entering account and password");
        await expect(page).toFill("input[name='gov_id']", fakeData.id);
        await expect(page).toFill("input[name='password']", fakeData.password);
        console.log("login");
        await expect(page).toClick("#form-submit");
        await page.waitForNavigation();
        console.log("logout");
        await expect(page).toClick("a[href='https://hucc-demo.estiginto.com/logout']");
        await page.waitForNavigation();
        console.log("valid URL");
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/");
    } finally {
        await page.waitFor(10000);
        await browser.close();
    }
}, 60*1000);
