import ReactGA from "react-ga";

class GALotteryIntroductionPage {
    // ===== 彩種介紹頁 (LotteryIntroduction) =====
    private static PageIdentity = "LotteryIntroduction";

    // 7. 淘宝两分彩彩种介绍页中点击"历史奖号"（上方）
    public static eventTriggerHistoryTop(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryIntroductionPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_History_Top`,
        });
    }
    // 8. 淘宝两分彩彩种介绍页中点击"奖源验证"（上方）
    public static eventTriggerValdationTop(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryIntroductionPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Validation_Top`,
        });
    }
    // 9. 淘宝两分彩彩种介绍页中点击"历史奖号"（页底）
    public static eventTriggerHistoryBottom(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryIntroductionPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_History_Bottom`,
        });
    }
    // 10. 淘宝两分彩彩种介绍页中点击"奖源验证"（页底）
    public static eventTriggerValdationBottom(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryIntroductionPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Validation_Bottom`,
        });
    }
    // 11. 淘宝两分彩彩种介绍页中点击"奖号取得"
    public static eventTriggerSource(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: GALotteryIntroductionPage.PageIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Source`,
        });
    }
}
export default GALotteryIntroductionPage;
