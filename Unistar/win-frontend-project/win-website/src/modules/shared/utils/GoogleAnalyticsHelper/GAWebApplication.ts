import ReactGA from "react-ga";

class GAWebApplication {
    private static PageIdentity = "WebApplication";
    // ===== 網站開啟 =====
    // 1. 奖源8开启
    public static eventTriggerLoad() {
        ReactGA.event({
            category: GAWebApplication.PageIdentity,
            action: `Load`,
        });
    }
}

export default GAWebApplication;
