/**
 education
 <option value="">選擇教育程度</option>
 <option value="07">國小</option>
 <option value="06">國中</option>
 <option value="05">高中職</option>
 <option value="04">專科</option>
 <option value="03">大學</option>
 <option value="02">碩士</option>
 <option value="01">博士</option>
 <option value="08">其他</option>
 occupation
 <option value="">選擇職業</option>
 <option value="11">全職學生</option>
 <option value="12">全職工作者</option>
 <option value="13">兼職工作者(含自由業者者)</option>
 <option value="07">家管</option>
 <option value="08">退休</option>
 <option value="09">其他</option>
 * */
import launchConfig from "../configs/launch.config";
import mouseHelper from "../configs/mouseHelper";
import puppeteer from "puppeteer";
import expectPuppeteer from "expect-puppeteer";

const fakeData = {
    id: "A135168605", // 身分證
    year: "2000", // 年
    month: "12", // 月
    day: "12", // 日
    name: "測試姓名輸入", // 姓名
    homeAreaCode: "", // 住宅地區號碼
    homePhone: "", // 住宅
    mobilePhone: "0918233241", // 手機
    companyAreaCode: "", // 公司地區號碼
    companyPhone: "", // 公司
    email: "aa@gmail.com", // 信箱(選填)
    education: "03", // 教育程度(選填)
    occupation: "09", // 職業
    householdSize: "4", // 家庭人數(選填)
    memberInfos: [1, 3, 5, 7, 9], // 家庭成員
    cookingStyle: [1], // 主要料理風格
    socialConcerns: [3], // 關注議題
    informationSource: [2], // 訊息來源
    newspaperSubscribe: false, // 電子報訂閱設定
    monthlyMagazineReceivedWay: false, // 月刊領取方式
    cardReceivedWay: false, // 卡片領取方式
};

test("Testing register", async () => {
    const browser = await puppeteer.launch(launchConfig);
    const page = await browser.newPage();
    await mouseHelper(page);
    await page.setViewport(launchConfig.viewport);

    try {
        console.log("open home page");
        await page.mainFrame().goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
        console.log("click join us");
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/joinus']");
        await page.waitForNavigation();
        console.log("click register");
        await expectPuppeteer(page).toClick("a[href='https://hucc-demo.estiginto.com/register']");
        await page.waitForNavigation();

        // step 0
        console.log("step 0");
        await expectPuppeteer(page).toFill("#input_gov_id", fakeData.id);
        await page.select("#year", fakeData.year);
        await page.select("#month", fakeData.month);
        await page.select("#day", fakeData.day);
        await page.click("body > div.body-inner > section > div > div > div > form > div.text-center.m-b-30 > input");
        await page.waitForNavigation();

        // step 1
        console.log("step 1");
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(2) > div > input", fakeData.id);
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(2) > input", fakeData.mobilePhone);
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(4) > div > div.form-group.col-3.col-md-3 > input", fakeData.homeAreaCode);
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(4) > div > div.form-group.col-9.col-md-8 > input", fakeData.homePhone);
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(6) > div > div.form-group.col-3.col-md-3 > input", fakeData.companyAreaCode);
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(6) > div > div.form-group.col-9.col-md-8 > input", fakeData.companyPhone);
        await expectPuppeteer(page).toFill("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(12) > div > input", fakeData.email);
        await page.$eval("select[name='education']", (element) => element.setAttribute("value", fakeData.education));
        await page.$eval("select[name='occupation']", (element) => element.setAttribute("value", fakeData.occupation));
        await expectPuppeteer(page).toFill("input[name='household_size']", fakeData.householdSize);

        for (const i of fakeData.memberInfos) {
            await expectPuppeteer(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(22) > div > div > div:nth-child("+i+") > label");
        }

        for (const i of fakeData.cookingStyle) {
            await expectPuppeteer(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(26) > div > div > div:nth-child("+i+") > label");
        }

        for (const i of fakeData.socialConcerns) {
            await expectPuppeteer(page).toClick("#Tab-A > div > div:nth-child("+i+") > label");
        }

        for (const i of fakeData.informationSource) {
            await expectPuppeteer(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(32) > div > div > div:nth-child("+i+") > label");
        }

        await expectPuppeteer(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(34) > div > div > div:nth-child("+(fakeData.newspaperSubscribe ? 1 : 2)+") > label");
        await expectPuppeteer(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(36) > div > div > div:nth-child("+(fakeData.monthlyMagazineReceivedWay ? 1 : 2)+") > label");
        await expectPuppeteer(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(38) > div > div > div:nth-child("+(fakeData.cardReceivedWay ? 1 : 2)+") > label");
        await expectPuppeteer(page).toClick("input[id='agree-term']");
        await expectPuppeteer(page).toClick("input[type='submit']");
        await page.waitForNavigation();

        // step 2
        console.log("step 2");
        // await page.waitFor(300*1000) //video play
        // step 3
        // await expectPuppeteer(page).toFill('#input_gov_id', fakeData.id)
        // step 4
        // await expectPuppeteer(page).toFill('#input_gov_id', fakeData.id)
    } finally {
        await page.waitFor(10000);
        await browser.close();
    }
}, 60*1000);
