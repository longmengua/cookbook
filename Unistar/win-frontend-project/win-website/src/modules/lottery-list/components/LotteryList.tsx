import React, {useState, useCallback, useEffect} from "react";
import {Link} from "react-router-dom";
import {GetGameSettingAJAXResponse} from "type/api";
import CDNHelper from "modules/shared/utils/CDNHelper";
import {GALotteryListPage} from "modules/shared/utils/GoogleAnalyticsHelper";

interface LotteryListProps {
    data: GetGameSettingAJAXResponse[];
}

class LotteryList extends React.Component<LotteryListProps> {
    public render(): JSX.Element {
        // 15 per page
        const lotteryListComponent: React.ReactElement[] = [];
        const hasData = this.props && this.props.data && this.props.data.length > 0;
        if (hasData) {
            this.props.data.forEach((lottery, index): void => {
                if (!lottery) {
                    return;
                }
                lotteryListComponent.push(
                    <li key={index}>
                        <div>
                            <img src={CDNHelper.CDNPath + lottery.logoUrl} />
                            {/* <Image source={String(AppConfig.CDN + lottery.logo_url)} /> */}
                            {/* <img src={require("presentation/asset/images/lottery01.png")} /> */}
                            {/* <ImageWithStatusText imageUrl={AppConfig.CDN + lottery.logo_url} ></ImageWithStatusText> */}
                        </div>
                        <h3>{lottery.displayName}</h3>
                        <div className="info-text">{lottery.gameIntroduction}</div>
                        <div className="lottery-hover">
                            <Link
                                to={{
                                    pathname: "/lotteryInfo/" + lottery.gameCode,
                                    state: {
                                        lotteryName: lottery.displayName,
                                    },
                                }}
                                onClick={() => GALotteryListPage.eventTriggerIntroduction(lottery.gameCode)}
                            >
                                <div className="more-btn info-btn">彩种介绍</div>
                            </Link>
                            <Link
                                to={{
                                    pathname: "/lotteryHistory/" + lottery.gameCode,
                                    state: {
                                        lotteryName: lottery.displayName,
                                    },
                                }}
                                onClick={() => GALotteryListPage.eventTriggerHistory(lottery.gameCode)}
                            >
                                <div className="more-btn history-btn">历史奖号</div>
                            </Link>
                        </div>
                    </li>
                );
            });
            return <ul className="lottery-info">{lotteryListComponent}</ul>;
        } else {
            return (
                <ul className="lottery-info">
                    <li className="lottery-none" />
                </ul>
            );
        }
    }
}

export default LotteryList;
