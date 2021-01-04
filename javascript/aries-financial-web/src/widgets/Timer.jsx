import {useState} from "react";
import * as React from 'react';
import moment from "moment-timezone";
import {Button, Typography} from "@material-ui/core";

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
    return (_moment().weekday() === 0) ? text : `${diffDay} days ${diffHour}:${diffMinutes}:${diffSecond}.${diffMinSecond}`;
};

const Timer = (prop) => {
    const [uiState, setUiState] = useState(getRemainingTimeOfClaimReward());

    setTimeout(()=> {
        setUiState(getRemainingTimeOfClaimReward(prop.text));
    }, 1);

    return (<Button
        fullWidth
        className={ prop.actionButton }
        variant="outlined"
        color="primary"
        onClick={ () => prop.onClick() }
    >
        Harvest
    </Button>);
};

export default Timer;
