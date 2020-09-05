import generationOfTWDID from "../lib/idGeneration";
import passwordGeneration from "../lib/passwordGeneration";
import launchConfig from "../configs/launch.config";
import mouseHelper from "../configs/mouseHelper";
import puppeteer, {Browser, Page} from "puppeteer";
import expectPuppeteer from "expect-puppeteer";


describe("測試", () => {
    let browser: Browser;
    let page: Page;
    beforeAll( async ()=> {
        browser = await puppeteer.launch(launchConfig);
        page = await browser.newPage();
        await mouseHelper(page);
        await page.setViewport(launchConfig.viewport);
        await page.mainFrame().goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
    }, 60*1000);

    it("一般社員可以從登入畫面正常登入", async () => {
        const accountInfo = {
            id: "A222557716",
            password: "a1234567",
        };
        // navigate to login page
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member']");
        await page.waitForNavigation();
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/login");
        // enter account info
        await expectPuppeteer(page).toFill("input[name='gov_id']", accountInfo.id);
        await expectPuppeteer(page).toFill("input[name='password']", accountInfo.password);
        // click login button
        await expectPuppeteer(page).toClick("#form-submit");
        await page.waitForNavigation();
        // except the url will be http://hucc.test/member
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/member");
    }, 60*1000);

    it("一般社員可以從社員專區登出", async () => {
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/logout']");
        await page.waitForNavigation();
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/");
    }, 60*1000);

    it("一般社員從登入畫面輸入錯誤密碼無法登入", async ()=>{
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member']");
        await page.waitForNavigation();
        await expect(await page.mainFrame().evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/login");
        // enter account info
        await expectPuppeteer(page).toFill("input[name='gov_id']", generationOfTWDID());
        await expectPuppeteer(page).toFill("input[name='password']", passwordGeneration());
        // click login button
        await expectPuppeteer(page).toClick("#form-submit");
        await page.waitForNavigation();
        // expect the error msg shows up.
        const string = await page.evaluate(() => document.querySelector("div[class='alert alert-danger']").textContent.indexOf("使用者名稱或密碼錯誤") > -1);
        expect(string).toBe(true);
    }, 60*1000);

    // it("", async ()=>{});
    // it("", async ()=>{});
    // it("", async ()=>{});

    afterAll(async ()=>{
        await browser.close();
    }, 60*1000);
});
