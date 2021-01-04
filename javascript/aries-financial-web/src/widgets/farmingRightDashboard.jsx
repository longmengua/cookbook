import * as React from 'react';
import "./farmingRightDashboard.sass";
import i18next from "i18next";
import {formatPercentage} from "../util/Format";

const FarmingRightDashboard = (prop) => {
    // console.log("FarmingRightDashboard==", prop);
    return <div id={"FarmingRightDashboard"}>
        <div id={"FarmingRightDashboard-Text-1"}>{i18next.t("FarmingRightDashboard-Text-1")}</div>
        <div>
            {prop.AFIPrice}
            {i18next.t("FarmingRightDashboard-Text-5")}
        </div>
        <div id={"FarmingRightDashboard-Text-2"}>{i18next.t("FarmingRightDashboard-Text-2")}</div>
        <div>{prop.AFIStakingAPY} %</div>
        <div id={"FarmingRightDashboard-Text-3"}>{i18next.t("FarmingRightDashboard-Text-3")}</div>
        <div>{formatPercentage(prop.AFIStaked, 2)}</div>
        <div id={"FarmingRightDashboard-Text-4"}>{i18next.t("FarmingRightDashboard-Text-4")}</div>
        <div>{formatPercentage(prop.AFIPooled, 1)}</div>
    </div>;
};

export default FarmingRightDashboard;