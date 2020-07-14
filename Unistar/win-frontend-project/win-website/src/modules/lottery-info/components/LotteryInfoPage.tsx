import React, {useState, useMemo, useCallback} from "react";
// import "presentation/styles/pages/";
// import "../../styles/pages/lotteryInfo.scss";
// import "./style.scss";

import CommonTemplates from "../../shared/components/templates/CommonTemplates";
import {Link} from "react-router-dom";
import LotteryInfoHeader from "../../shared/components/molecular/LotteryInfoHeader";
import {GetGameSettingAJAXResponse} from "type/api";
import FetchComponent from "react-fetch-component";
import CDNHelper from "../../shared/utils/CDNHelper";
import classNames from "classnames";
import {GameWinningNumberAJAXPaging} from "type/api";
import {GALotteryIntroductionPage} from "modules/shared/utils/GoogleAnalyticsHelper";

interface BottomButtonGroupProps {
    gameCode: string;
    currentIssue: GetGameSettingAJAXResponse;
}
const BottomButtonGroup = (props: BottomButtonGroupProps) => {
    return (
        <div className="content-bottom">
            <Link
                to={{
                    pathname: "/lotteryHistory/" + props.gameCode,
                }}
                onClick={() => GALotteryIntroductionPage.eventTriggerHistoryBottom(props.gameCode)}
            >
                <div className="more-btn history-btn">历史奖号</div>
            </Link>

            {props.currentIssue && props.currentIssue.referenceUrl && (
                <div
                    className="more-btn"
                    onClick={() => {
                        GALotteryIntroductionPage.eventTriggerValdationBottom(props.gameCode);
                        window.open(String(props.currentIssue.referenceUrl));
                    }}
                >
                    奖源验证
                </div>
            )}
        </div>
    );
};

interface LotteryHTMLContentProps {
    contentURL: string;
    gameCode: string;
    currentIssue: GetGameSettingAJAXResponse;
}
const LotteryHTMLContent = (props: LotteryHTMLContentProps): React.FunctionComponentElement<{}> => {
    const [load, setLoad] = useState(false);
    return (
        <div className="lottery-list-content">
            {/* <!--Text Content--> */}
            <FetchComponent url={props.contentURL}>
                {({loading, error, data}) => {
                    if (!loading) {
                        setLoad(true);
                    }
                    return (
                        <div className="text-content">
                            {loading && <>{/* "Loading" */}</>}
                            {error && <>{/* "Error" */}</>}
                            {data && <div dangerouslySetInnerHTML={{__html: data}} />}
                        </div>
                    );
                }}
            </FetchComponent>
            {load && <BottomButtonGroup gameCode={props.gameCode} currentIssue={props.currentIssue} />}
        </div>
    );
};

interface IntroductionProps {
    contentURL: string;
    gameCode: string;
    currentIssue: GetGameSettingAJAXResponse;
}
const Introduction = (props: IntroductionProps): React.FunctionComponentElement<{}> => {
    const [load, setLoad] = useState(false);
    return (
        <div className="lottery-list-content">
            {/* <!--Text Content--> */}
            <FetchComponent url={props.contentURL}>
                {({loading, error, data}) => {
                    if (!loading) {
                        setLoad(true);
                    }
                    return (
                        <div className="text-content">
                            {loading && <>{/* "Loading" */}</>}
                            {error && <>{/* "Error" */}</>}
                            {data && <div dangerouslySetInnerHTML={{__html: data}} />}
                        </div>
                    );
                }}
            </FetchComponent>
            {load && <BottomButtonGroup gameCode={props.gameCode} currentIssue={props.currentIssue} />}
        </div>
    );
};

interface ValidationInfoProps {
    validationURL: string;
    gameCode: string;
    currentIssue: GetGameSettingAJAXResponse;
}
const ValidationInfo = (props: ValidationInfoProps) => {
    const [load, setLoad] = useState(false);
    return (
        <div className="lottery-list-content">
            {/* <!--Text Content--> */}
            <FetchComponent url={props.validationURL}>
                {({loading, error, data}) => {
                    if (!loading) {
                        setLoad(true);
                    }
                    return (
                        <div className="text-content">
                            {loading && <>{/* "Loading" */}</>}
                            {error && <>{/* "Error" */}</>}
                            {data && <div dangerouslySetInnerHTML={{__html: data}} />}
                        </div>
                    );
                }}
            </FetchComponent>
            {load && <BottomButtonGroup gameCode={props.gameCode} currentIssue={props.currentIssue} />}
        </div>
    );
};
interface ComponentProps {
    history: GameWinningNumberAJAXPaging | undefined;
    gameSetting: GetGameSettingAJAXResponse | undefined;
}

enum TabInfo {
    IntroductionInfo,
    ValidationInfo,
}

export default function LotteryInfoPage(props: ComponentProps) {
    if (!props.gameSetting || !props.history) {
        return null;
    }
    const [tabInfo, setTabInfo] = useState<TabInfo>(TabInfo.IntroductionInfo);

    let contentURL: string = "";
    if (props.gameSetting.contentUrl) {
        // if (!PRODUCTION) {
        //     contentURL = "/temp/lotteryIntroduction.html";
        // } else {
        contentURL = CDNHelper.CDNPath + props.gameSetting.contentUrl;
        // }
    }
    let validationURL: string = "";
    if (props.gameSetting.referenceContentUrl) {
        validationURL = CDNHelper.CDNPath + props.gameSetting.referenceContentUrl;
    }
    const changeTab = useCallback(
        (tabInfo: TabInfo) => {
            setTabInfo(tabInfo);
        },
        [tabInfo]
    );
    return (
        <CommonTemplates>
            <div className="sub-bg">
                <div className="container">
                    <div className={classNames("lottery-list-wrapper", {keno: props.gameSetting.ballCount >= 20})}>
                        {/* <!--Open Lottery--> */}
                        <div className="open-lottery">
                            <LotteryInfoHeader lotteryName={props.gameSetting.displayName} lastIssue={props.history.gameWinningNumbers[0]} logoUrl={props.gameSetting.logoUrl} />

                            <div className={classNames("lottery-btn")}>
                                <Link
                                    to={{
                                        pathname: "/lotteryHistory/" + props.gameSetting.gameCode,
                                        state: {
                                            lotteryName: props.gameSetting.displayName,
                                        },
                                    }}
                                    onClick={() => {
                                        if (props.gameSetting) {
                                            GALotteryIntroductionPage.eventTriggerHistoryTop(props.gameSetting.gameCode);
                                        }
                                    }}
                                >
                                    <div className="more-btn history-btn">历史奖号</div>
                                </Link>

                                {props.gameSetting.referenceUrl && (
                                    <div
                                        className="more-btn"
                                        onClick={() => {
                                            if (props.gameSetting) {
                                                GALotteryIntroductionPage.eventTriggerValdationTop(props.gameSetting.gameCode);
                                                window.open(String(props.gameSetting.referenceUrl));
                                            }
                                        }}
                                    >
                                        奖源验证
                                    </div>
                                )}
                            </div>
                        </div>

                        {/* <!--Lottery List Menu--> */}
                        <div className="lottery-list-menu">
                            <ul>
                                <li
                                    className={classNames({active: tabInfo === TabInfo.IntroductionInfo})}
                                    onClick={() => {
                                        changeTab(TabInfo.IntroductionInfo);
                                    }}
                                >
                                    彩种介绍
                                </li>
                                {props.gameSetting.referenceContentUrl && (
                                    <li
                                        className={classNames({active: tabInfo === TabInfo.ValidationInfo})}
                                        onClick={() => {
                                            if (props.gameSetting) {
                                                GALotteryIntroductionPage.eventTriggerSource(props.gameSetting.gameCode);
                                            }
                                            changeTab(TabInfo.ValidationInfo);
                                        }}
                                    >
                                        数据取得
                                    </li>
                                )}
                            </ul>
                        </div>
                        {/* <!--End Lottery List Menu--> */}

                        {/* <!--Lottery List Content--> */}
                        {tabInfo === TabInfo.IntroductionInfo ? <Introduction gameCode={props.gameSetting.gameCode} currentIssue={props.gameSetting} contentURL={contentURL} /> : <ValidationInfo gameCode={props.gameSetting.gameCode} currentIssue={props.gameSetting} validationURL={validationURL} />}
                        {/* <!--End Lottery List Content--> */}
                        {/* <!--End Text Content--> */}
                    </div>
                </div>
            </div>
        </CommonTemplates>
    );
}
