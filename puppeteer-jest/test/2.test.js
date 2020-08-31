require("expect-puppeteer")
const puppeteer = require("puppeteer")
const {installMouseHelper} = require("../configs/mouseHelper")
const {launchConfig} = require("../configs/launch.config")

const occupations = [
    "全職學生",
    "全職工作者",
    "兼職工作者(含自由業者者)",
    "家管",
    "退休",
    "其他",
]
const educations = [
    "國小",
    "國中",
    "高中職",
    "專科",
    "大學",
    "碩士",
    "博士",
    "其他",
]

const fakeData = {
    id: "A135168605",//身分證
    year: "2000",//年
    month: "12",//月
    day: "12",//日
    name: "測試姓名輸入",//姓名
    homeAreaCode: "",//住宅地區號碼
    homePhone: "",//住宅
    mobilePhone: "0918233241",//手機
    companyAreaCode: "",//公司地區號碼
    companyPhone: "",//公司
    email: "aa@gmail.com",//信箱(選填)
    education: educations[0],//教育程度(選填)
    occupation: occupations[0],//職業
    householdSize: "4",//家庭人數(選填)
    memberInfos: [1,3,5,7,9],//家庭成員
    cookingStyle: [1],//主要料理風格
    socialConcerns: [3],//關注議題
    informationSource: [2],//訊息來源
    newspaperSubscribe: false,//電子報訂閱設定
    monthlyMagazineReceivedWay: false,//月刊領取方式
    cardReceivedWay: false,//卡片領取方式
}

test("Testing register", async () => {

    const browser = await puppeteer.launch(launchConfig)
    const page =  await browser.newPage()
    await installMouseHelper(page)
    await page.setViewport(launchConfig.viewport)

    try {
        console.log("open url")
        await page.mainFrame().goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com")
        console.log("click join us")
        await expect(page).toClick('a[href="https://hucc-demo.estiginto.com/joinus"]')
        await page.waitForNavigation()
        console.log("click register")
        await expect(page).toClick('a[href="https://hucc-demo.estiginto.com/register"]')
        await page.waitForNavigation()

        //step 0
        console.log("step 0")
        await expect(page).toFill('#input_gov_id', fakeData.id)
        await page.select('#year', fakeData.year)
        await page.select('#month', fakeData.month)
        await page.select('#day', fakeData.day)
        await page.click("body > div.body-inner > section > div > div > div > form > div.text-center.m-b-30 > input")
        await page.waitForNavigation()

        //step 1
        console.log("step 1")
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(2) > div > input', fakeData.id)
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(2) > input', fakeData.mobilePhone)
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(4) > div > div.form-group.col-3.col-md-3 > input', fakeData.homeAreaCode)
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(4) > div > div.form-group.col-9.col-md-8 > input', fakeData.homePhone)
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(6) > div > div.form-group.col-3.col-md-3 > input', fakeData.companyAreaCode)
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(10) > div > div > div:nth-child(6) > div > div.form-group.col-9.col-md-8 > input', fakeData.companyPhone)
        await expect(page).toFill('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(12) > div > input', fakeData.email)
        await expect(page).toMatchElement('option', fakeData.education)
        await page.select('body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(18) > div > select', fakeData.occupation)
        await expect(page).toFill('input[name="household_size"]', fakeData.householdSize)

        for (let i of fakeData.memberInfos) {
            await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(22) > div > div > div:nth-child("+i+") > label")
        }

        for (let i of fakeData.cookingStyle) {
            await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(26) > div > div > div:nth-child("+i+") > label")
        }

        for (let i of fakeData.socialConcerns) {
            await expect(page).toClick("#Tab-A > div > div:nth-child("+i+") > label")
        }

        for (let i of fakeData.informationSource) {
            await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(32) > div > div > div:nth-child("+i+") > label")
        }

        await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(34) > div > div > div:nth-child("+(fakeData.newspaperSubscribe ? 1 : 2)+") > label")
        await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(36) > div > div > div:nth-child("+(fakeData.monthlyMagazineReceivedWay ? 1 : 2)+") > label")
        await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(38) > div > div > div:nth-child("+(fakeData.cardReceivedWay ? 1 : 2)+") > label")
        await expect(page).toClick("input[id='agree-term']")
        await expect(page).toClick("input[type='submit']")
        await page.waitForNavigation()

        //step 2
        console.log("step 2")
        // await expect(page).toFill('#input_gov_id', fakeData.id)
        //step 3
        // await expect(page).toFill('#input_gov_id', fakeData.id)
        //step 4
        // await expect(page).toFill('#input_gov_id', fakeData.id)

    } finally {
        await page.waitFor(10000)
        await browser.close()
    }
}, 60*1000)
