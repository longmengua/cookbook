import ReactGA from "react-ga";
import GAPageTrackerInterface from "./PageGoogleAnalyticsTracker/GAPageTrackerInterface";

interface GAHomePageInterface extends GAPageTrackerInterface {
    // 2. 首页中点击淘宝两分彩的"彩种介绍"
    eventTriggerIntroduction: (lotteryIdentity: string, elementEvent: string) => void;
    // 3. 首页中点击淘宝两分彩的"历史奖号"
    eventTriggerHistory: (lotteryIdentity: string, elementEvent: string) => void;
}

class GAHomePage implements GAHomePageInterface {
    // ===== 首頁 =====
    public pageViewIdentity = "Home";

    // SingleTon
    private static instance: any;
    public static getInstance(): any {
        if (!GAHomePage.instance) {
            GAHomePage.instance = new GAHomePage();
        }
        return GAHomePage.instance;
    }

    public eventTriggerIntroduction(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: this.pageViewIdentity,
            action: `${elementEvent}_${lotteryIdentity}_Introduction`,
        });
    }
    public eventTriggerHistory(lotteryIdentity: string, elementEvent: string = "Click") {
        ReactGA.event({
            category: this.pageViewIdentity,
            action: `${elementEvent}_${lotteryIdentity}_History`,
        });
    }
}
export default GAHomePage;
