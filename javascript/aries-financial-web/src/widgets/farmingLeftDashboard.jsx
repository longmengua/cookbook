import * as React from 'react';
import "./farmingLeftDashboard.sass";
import i18next from "i18next";
import {formatMarketCap, formatMoney} from "../util/Format";

const FarmingLeftDashboard = (prop) => {
    // console.log("FarmingLeftDashboard==", prop);
    return <div id={"FarmingLeftDashboard"}>
        <div id={"FarmingLeftDashboard-Text-1"}>{i18next.t("FarmingLeftDashboard-Text-1")}</div>
        <div className={"FarmingLeftDashboard-Text-3"}>
            {formatMoney(prop.depositsInAries.toFixed(2))}
            {i18next.t("FarmingLeftDashboard-Text-3")}
        </div>
        <div id={"FarmingLeftDashboard-Text-2"}>{i18next.t("FarmingLeftDashboard-Text-2")}</div>
        <div className={"FarmingLeftDashboard-Text-3"}>
            {formatMarketCap(prop.marketCap, 2)}
            {i18next.t("FarmingLeftDashboard-Text-3")}
        </div>
    </div>;
};

export default FarmingLeftDashboard;