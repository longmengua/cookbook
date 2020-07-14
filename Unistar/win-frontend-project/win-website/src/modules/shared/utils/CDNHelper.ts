// CDN
// old: AppConfig.CDN
// new: window.CDNPath

// FIXME JSON file typescript
// import AppConfig from "env/app.json"
const AppConfig = require("conf/ui.json");

export default class CDNHelper {
    public static get CDNPath(): string {
        let cdnPathIgnoreTail = "";
        if (location.host.indexOf("localhost") > -1) {
            cdnPathIgnoreTail = AppConfig.CDN;
        } else {
            cdnPathIgnoreTail = window.CDNPath;
        }
        return cdnPathIgnoreTail;
    }
}
