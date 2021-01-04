import {useState} from "react";
import * as React from 'react';
import moment from "moment-timezone";
import "./farmingClock.sass";
import i18next from "i18next";

/**
 * About the moment.js with time zone usage, please see https://momentjs.com/timezone/docs/
 */
const timeZone = "Etc/GMT0";
const getRemainingTimeOfClaimReward = (text) => {
    const _moment = moment.tz.setDefault(timeZone);
    const start = _moment().weekday(0);

    const diffDay = _moment().endOf('w').diff(_moment().endOf('d'), "d");
    const diffHour = _moment().weekday(0).endOf('d').diff(start, "h");
    const diffMinutes = _moment().weekday(0).endOf('h').diff(start, "m");
    const diffSecond = _moment().weekday(0).endOf('m').diff(start, "s");
    const diffMinSecond = _moment().weekday(0).endOf('s').diff(start, "ms");
    const result = `${diffDay} days ${diffHour}:${diffMinutes}:${diffSecond}.${diffMinSecond}`;
    // console.log(_moment.tz.names(), "All time zone ==");
    // console.log(result, "result - timer ==");
    // console.log(_moment().toString(), "timer ==");
    // console.log(_moment().weekday(0).toString(), "timer ==");
    // console.log(_moment().tz(), "timer ==");
    // console.log(_moment().endOf('w').toString(), "timer ==");
    // console.log(_moment().endOf('d').toString(), "timer ==");
    return (_moment().weekday() === 0) ? text : result;
};

const FarmingClock = (prop) => {
    const [uiState, setUiState] = useState(getRemainingTimeOfClaimReward());

    setTimeout(()=> {
        setUiState(getRemainingTimeOfClaimReward(prop.text));
    }, 1);

    const openUrl = () => {
        window.open("https://app.uniswap.org/#/swap?inputCurrency=0x68e8a20128e1902c02f533a02ed0cfd8396e3fbc&outputCurrency=0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48", "_blank")
    };

    return <div id={"FarmingClock"}>
        <div className={"space"}/>
        <div className={"title"}>{i18next.t("FarmingClock-Text-1")}</div>
        <div className={"space"}/>
        <div className={"timer"}>{uiState}</div>
        <div className={"space"}/>
        <div className={`Button`} onClick={() => openUrl()}>{i18next.t("FarmingClock-Text-2")}</div>
        <div className={"space"}/>
    </div>;
};

export default FarmingClock;