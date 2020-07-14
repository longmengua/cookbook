import ReactGA from "react-ga";

class GALotteryListPage {
    // ===== 彩種列表頁 =====
    private static PageIdentity = "LotteryList";
    // 5. 彩种列表页中点击淘宝两分彩的"彩种介绍"
    public static eventTriggerIntroduction(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryListPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Introduction`,
        });
    }
    // 6. 彩种列表页中点击淘宝两分彩的"历史奖号"
    public static eventTriggerHistory(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryListPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_History`,
        });
    }
}
export default GALotteryListPage;
