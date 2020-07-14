import ReactGA from "react-ga";

class GALotteryHistoryPage {
    // ===== 彩種歷史獎號 =====
    private static PageIdentity = "LotteryHistory";

    // 12. 淘宝两分彩历史奖号页中点击"彩种介绍"（上方）
    public static eventTriggerIntroduction(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryHistoryPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Introduction`,
        });
    }

    // 13. 淘宝两分彩历史奖号页中点击"奖源验证"（上方）
    public static eventTriggerValidation(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryHistoryPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Validation`,
        });
    }
}
export default GALotteryHistoryPage;
