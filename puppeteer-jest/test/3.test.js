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
    homeAreaCode: "02",//住宅地區號碼
    homePhone: "",//住宅
    mobilePhone: "0918233241",//手機
    companyAreaCode: "02",//公司地區號碼
    companyPhone: "",//公司
    email: "aa@gmail.com",//信箱(選填)
    education: educations[0],//教育程度(選填)
    occupation: occupations[0],//職業
    householdSize: "4",//家庭人數(選填)
    checkBoxs: [31,22,15,16,7,4,9,8,14],//所有checkbox選項
}

test("Testing register", async () => {

    const browser = await puppeteer.launch(launchConfig)
    const page =  await browser.newPage()
    await installMouseHelper(page)

    try {
        await page.mainFrame().goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com/register/step1", {waitUntil: "networkidle2"})
        await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(22) > div > div > div:nth-child(3) > label")
        await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(26) > div > div > div:nth-child(1) > label")
        await expect(page).toClick("#Tab-A > div > div:nth-child(1) > label")
        await expect(page).toClick("body > div.body-inner > section > div > div > div:nth-child(1) > form > div:nth-child(32) > div > div > div:nth-child(1) > label")
    } finally {
        await page.waitFor(5000)
        await browser.close()
    }
}, 30*1000)
