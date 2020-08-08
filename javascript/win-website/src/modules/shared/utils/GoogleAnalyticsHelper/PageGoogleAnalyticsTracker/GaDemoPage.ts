import ReactGA from "react-ga";
import GAPageTrackerInterface from "./GAPageTrackerInterface";

class GaDemoPage implements GAPageTrackerInterface {
    pageViewIdentity: string;
    private static instance: any;
    public static getInstance(): any {
        if (!GaDemoPage.instance) {
            GaDemoPage.instance = new GaDemoPage("DemoPage");
        }
        return GaDemoPage.instance;
    }
    constructor(pageViewIdentity: string) {
        this.pageViewIdentity = pageViewIdentity;
    }
    public trigerButton(elementEvent: string = "Click") {
        ReactGA.event({
            category: this.pageViewIdentity,
            action: `${elementEvent}`,
        });
    }
}

export default GaDemoPage;
