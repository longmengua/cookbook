import generationOfTWDID from "../lib/idGeneration";
import passwordGeneration from "../lib/passwordGeneration";
import launchConfig from "../configs/launch.config";
import mouseHelper from "../configs/mouseHelper";
import puppeteer, {Browser, Page} from "puppeteer";
import expectPuppeteer from "expect-puppeteer";


describe("測試", () => {
    let browser: Browser;
    let page: Page;
    let addressListLength: number;

    beforeAll( async ()=> {
        browser = await puppeteer.launch(launchConfig);
        page = await browser.newPage();
        await mouseHelper(page);
        await page.setViewport(launchConfig.viewport);
        await page.goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
    }, 60*1000);

    it("一般社員從登入畫面輸入錯誤密碼無法登入", async ()=>{
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member']");
        await page.waitForNavigation();
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/login");
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

    it("一般社員可以從登入畫面正常登入", async () => {
        const accountInfo = {
            id: "A222557716",
            password: "a1234567",
        };
        // navigate to login page
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member']");
        await page.waitForNavigation();
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/login");
        // enter account info
        await expectPuppeteer(page).toFill("input[name='gov_id']", accountInfo.id);
        await expectPuppeteer(page).toFill("input[name='password']", accountInfo.password);
        // click login button
        await expectPuppeteer(page).toClick("#form-submit");
        await page.waitForNavigation();
        // except the url will be http://hucc.test/member
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/member");
    }, 60*1000);

    it("一般社員可以查看自己的常用地址:before insertion", async ()=>{
        // navigate to address page
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member/address/list']");
        await page.waitForNavigation();
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/member/address/list");
        const elements = await page.$$("table > tbody > tr");
        addressListLength = elements.length;
    });

    it("一般社員可以新增自己的常用地址", async () => {
        const cities = [
            "基隆市", "台北市", "新北市", "宜蘭縣", "新竹市", "新竹縣",
            "桃園市", "苗栗縣", "台中市", "彰化縣", "南投縣", "嘉義市",
            "嘉義縣", "雲林縣", "台南市", "台東縣", "屏東縣", "高雄市",
            "花蓮縣", "金門縣", "連江縣", "澎湖縣",
        ];
        const information = {
            name: "收件人姓名", // 收件人姓名
            phone: "0987654321", // 手機
            homeAreaCode: "0987654321", // 住宅
            homePhone: "0987654321", // 住宅
            mail: "xx@google.com", // 收件人電子信箱
            addressAreaCode: "002", // 收件地址
            street: "xxx, xxx, xxx", // 詳細地址

        };
        // navigate to create address page
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/member/address/add']");
        await page.waitForNavigation();
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/member/address/add");
        // enter information
        await expectPuppeteer(page).toFill("input[name='name']", information.name);
        await expectPuppeteer(page).toFill("input[name='phone_cell']", information.phone);
        await expectPuppeteer(page).toFill("input[name='phone_area_code']", information.homeAreaCode);
        await expectPuppeteer(page).toFill("input[name='phone_local']", information.homePhone);
        await expectPuppeteer(page).toFill("input[name='email']", information.mail);
        // await expect(page).toFill("input[name='zip']", information.addressAreaCode);// don't need, cause this will be generated with next selection.
        await expectPuppeteer(page).toSelect("select[name='city']", cities[Math.ceil(Math.random() * cities.length - 1)]);
        // todo: cause the options of towns will generate by the previous selection. so the testing will be liked a dynamic selection.
        await expectPuppeteer(page).toFill("input[name='street']", information.street);
        await expectPuppeteer(page).toClick("button[type='submit']");
        await page.waitForNavigation();
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/member/address/list");
    }, 60*1000);

    it("一般社員可以查看自己的常用地址:after insertion", async ()=>{
        const elements = await page.$$("table > tbody > tr");
        expect(addressListLength == elements.length).toBe(false);// the amount should be different after insertion.
    });

    it("一般社員可以移除自己的常用地址", async ()=>{
        await expectPuppeteer(page).toClick("table > tbody > tr > td > a");
        await page.waitForNavigation();
    });

    it("一般社員可以查看自己的常用地址:after delete", async ()=>{
        const elements = await page.$$("table > tbody > tr");
        expect(addressListLength == elements.length).toBe(true);// the amount should be same after delete.
    });

    it("一般社員可以從社員專區登出", async () => {
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/logout']");
        await page.waitForNavigation();
        await expect(await page.evaluate("location.href")).toBe("https://hucc-demo.estiginto.com/");
    }, 60*1000);

    afterAll(async ()=>{
        await browser.close();
    }, 60*1000);
});
