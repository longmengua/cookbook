import ReactGA from "react-ga";

class GACommon {
    private static instance: GACommon;
    private PageIdentity: string = "Common";
    // ===== 首頁 => 彩種列表 =====
    // 4. 首页中点击"彩种列表" (不限定首頁，增加_Header 表示)
    // public eventTriggerLotteryList(elementEvent: string = "Click") {
    //     ReactGA.event({
    //         category: `${this.PageIdentity}_Header`,
    //         action: `${elementEvent}_LotteryList`,
    //     });
    // }
    public pageviewTriggerLotteryList() {
        ReactGA.pageview("LotteryList");
    }
    public static getInstance(): GACommon {
        if (!GACommon.instance) {
            GACommon.instance = new GACommon();
        }
        return GACommon.instance;
    }
}
export default GACommon;
