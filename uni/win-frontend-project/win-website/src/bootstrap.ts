import loadScript from "./loadScript";
import {GAWebApplication} from "modules/shared/utils/GoogleAnalyticsHelper";

// function gtag(command: string, parms: any) {
//     window.dataLayer.push([command, parms]);
// }

// loadScript("https://www.googletagmanager.com/gtag/js?id=UA-146644455-2", {}, (err, script) => {
//     if (err) {
//         // print useful message
//         console.info("err", err);
//     } else {
//         console.info("success", script.src); // Prints 'foo'.js'
//         // use script
//         // note that in IE8 and below loading error wouldn't be reported
//         window.dataLayer = window.dataLayer || [];
//         gtag("js", new Date());
//         gtag("config", "UA-146644455-2");
//     }
// });

const loadDevGA = () => {
    ReactGA.initialize("UA-146644455-2");
};

const loadProdGA = () => {
    ReactGA.initialize("UA-146644455-1");
};

import ReactGA from "react-ga";

class Bootstrap {
    public constructor() {
        this.initCDNConfig();
        this.initGoogleAnalytics();
        this.recordGoogleAnalytics();
    }
    private initCDNConfig() {
        if (window.location.host.indexOf("localhost") > -1) {
            window.CDNPath = "/";
        } else {
            let CDNPATH;
            if (new RegExp(/www/).test(window.location.host)) {
                CDNPATH = "//" + window.location.host.replace(/www/, "static");
            } else {
                // fix some browser
                CDNPATH = `//static.${window.location.host}`;
            }
            window.CDNPath = CDNPATH;
            window.WebpackPublicPath = window.CDNPath + "/";
            __webpack_public_path__ = window.WebpackPublicPath;
        }
    }

    private initGoogleAnalytics() {
        if (window.location.host.indexOf("localhost") > -1 || window.location.host.indexOf("16888dev") > -1) {
            // Local, DEV
            loadDevGA();
        } else {
            // Prod
            loadProdGA();
        }
    }
    private recordGoogleAnalytics() {
        // Record
        GAWebApplication.eventTriggerLoad();
    }
}

export default new Bootstrap();
