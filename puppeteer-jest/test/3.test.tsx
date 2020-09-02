import generationOfTWDID from "../lib/idGeneration";
import launchConfig from "../configs/launch.config";
import mouseHelper from "../configs/mouseHelper";
import puppeteer from "puppeteer";
import expectPuppeteer from "expect-puppeteer";

const fakeRandomData = {
    id: generationOfTWDID(), // 身分證
    password: "a1234567",
};

const fakeData = {
    id: "A201574155", // 身分證
    password: "a1234567",
};

test("Testing login", async () => {
    const browser = await puppeteer.launch(launchConfig);
    const page = await browser.newPage();
    await mouseHelper(page);
    await page.setViewport(launchConfig.viewport);

    try {
        console.log("open home page");
        await page.mainFrame().goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
        console.log("click member");
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member']");
        await page.waitForNavigation();
        console.log("valid URL");
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/login");
        console.log("entering wrong account and password");
        await expectPuppeteer(page).toFill("input[name='gov_id']", fakeRandomData.id);
        await expectPuppeteer(page).toFill("input[name='password']", fakeRandomData.password);
        console.log("login");
        await expectPuppeteer(page).toClick("#form-submit");
        await page.waitForNavigation();
        console.log("entering account and password");
        await expectPuppeteer(page).toFill("input[name='gov_id']", fakeData.id);
        await expectPuppeteer(page).toFill("input[name='password']", fakeData.password);
        console.log("login");
        await expectPuppeteer(page).toClick("#form-submit");
        await page.waitForNavigation();
        console.log("logout");
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/logout']");
        await page.waitForNavigation();
        console.log("valid URL");
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/");
    } finally {
        await page.waitFor(10000);
        await browser.close();
    }
}, 60*1000);
