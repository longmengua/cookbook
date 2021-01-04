import * as React from 'react';
import {useState} from "react";
import "./APYFrame.sass"
import i18next from "i18next";

const APYFrame = (props) => {

    const { name, deposit, pool, reward, depositUrl, poolUrl, rewardUrl, onStake } = props;
    const token = props.tokens[0];
    const ariesAPY = token.ariesAPY;
    const hypeLink = (url) => url === "" ? null : url;
    const [uiState, setUiState] = useState(new Date().toTimeString());

    // setInterval(()=> {
    //
    // }, 1000);

    // console.log(token, "APYFrame ==");
    return <div className={`APYFrame ${props.className}`}>
        <div className={`Frame`}>
            <div className={`bold title no-wrap`}>{name || i18next.t("widgets-APYFrame-Text-3")}</div>
            <div className={`flex deposit`}>
                <div className={`margin-10 no-wrap`}>{i18next.t("widgets-APYFrame-Text-1")} : </div>
                <div className={`bold no-wrap`}>
                    <a href={hypeLink(depositUrl)} target="_blank" rel="noopener noreferrer">{deposit || i18next.t("widgets-APYFrame-Text-3")}</a>
                </div>
            </div>
            <div className={`flex pool`}>
                <div className={`margin-10 no-wrap`}>{i18next.t("widgets-APYFrame-Text-2")} : </div>
                <div className={`bold no-wrap`}>
                    <a href={hypeLink(poolUrl)} target="_blank" rel="noopener noreferrer">{pool || i18next.t("widgets-APYFrame-Text-3")}</a>
                </div>
            </div>
            <div className={`flex pool`}>
                <div className={`margin-10 no-wrap`}>{i18next.t("widgets-APYFrame-Text-4")} : </div>
                <div className={`bold no-wrap`}>
                    <a href={hypeLink(rewardUrl)} target="_blank" rel="noopener noreferrer">{reward || i18next.t("widgets-APYFrame-Text-3")}</a>
                </div>
            </div>
            <div className={`flex pool`}>
                <div className={`margin-10 no-wrap`}>{i18next.t("widgets-APYFrame-Text-6")} : </div>
                <div className={`bold no-wrap`}> {ariesAPY === 0 ? "N/A" : ariesAPY.toFixed(2)} %</div>
            </div>
            <div className={`Button bold margin-top-20`} onClick={onStake}>{i18next.t("widgets-APYFrame-Text-5")}</div>
        </div>
    </div>;
};

export default APYFrame;