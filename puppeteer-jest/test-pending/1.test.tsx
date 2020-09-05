import launchConfig from "../configs/launch.config";
import mouseHelper from "../configs/mouseHelper";
import puppeteer from "puppeteer";
import expectPuppeteer from "expect-puppeteer";


test("Testing navigation bars.", async () => {
    const browser = await puppeteer.launch(launchConfig);
    const page = await browser.newPage();
    await mouseHelper(page);
    await page.setViewport(launchConfig.viewport);
    const links = [
        "https://hucc-demo.estiginto.com/location/list",
        "https://hucc-demo.estiginto.com/joinus",
        "",
        "https://hucc-demo.estiginto.com/member",
        "https://hucc-demo.estiginto.com/shopping_cart",
    ];

    try {
        console.log("open home page.");
        await page.goto("https://hucc:7FytdQVj@hucc-demo.estiginto.com");
        console.log("there should be 5 buttons in navigation bar.");
        const elements = await page.$$(".single-icon");
        expect(elements).toHaveLength(5);
        console.log("check each link");
        for (let i = 0; i < elements.length; i++) {
            if (links[i] === "") continue;
            console.log("click the link", links[i]);
            await expectPuppeteer(page).toClick("a[href=\""+links[i]+"\"]");
            await page.waitForNavigation();
            console.log("go back");
            await page.goBack();
        }
    } finally {
        await browser.close();
    }
}, 60*1000);
