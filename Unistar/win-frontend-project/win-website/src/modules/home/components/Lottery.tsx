import React, {useMemo} from "react";
import {Link} from "react-router-dom";
import CDNHelper from "modules/shared/utils/CDNHelper";
import {FakeLotteryList} from "../types";
import {GAHomePage} from "modules/shared/utils/GoogleAnalyticsHelper";

// import "../../../styles/components/_lottery.scss";

interface Props {
    lotteryList: FakeLotteryList[];
}
export default function Lottery(props: Props) {
    // NOTE: maximun count is 5
    const lotteryComponents = useMemo(() => {
        const components: React.ReactElement[] = [];
        const hasDat = props.lotteryList && props.lotteryList.length > 0;
        if (hasDat) {
            props.lotteryList.forEach((lottery, index) => {
                components.push(
                    <li key={index}>
                        <h3>{lottery.display_name}</h3>
                        <div>
                            {/* <img src={require("../../../asset/images/lottery05.png")} /> */}
                            <img src={lottery.logo_url ? CDNHelper.CDNPath + lottery.logo_url : ""} />
                        </div>
                        {/* 文字介绍规定于十四个字以内。 */}
                        <div className="info-text">{lottery.game_introduction}</div>
                        <div className="lottery-hover">
                            <Link
                                to={{
                                    pathname: "/lotteryInfo/" + lottery.game_code,
                                }}
                                onClick={() => GAHomePage.getInstance().eventTriggerIntroduction(lottery.game_code)}
                            >
                                <div className="more-btn info-btn">彩种介绍</div>
                            </Link>
                            <Link
                                to={{
                                    pathname: "/lotteryHistory/" + lottery.game_code,
                                }}
                                onClick={() => GAHomePage.getInstance().eventTriggerHistory(lottery.game_code)}
                            >
                                <div className="more-btn history-btn">历史奖号</div>
                            </Link>
                        </div>
                    </li>
                );
            });
        }
        return components;
    }, [props.lotteryList]);

    return (
        <div className="lottery">
            <div className="lottery-item container">
                <h2>推荐彩种</h2>
                <ul className="lottery-info">{lotteryComponents}</ul>
            </div>
        </div>
    );
}
