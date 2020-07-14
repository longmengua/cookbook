import React, {FunctionComponent, useState, useEffect, useMemo, useCallback, useRef} from "react";
import CommonTemplates from "modules/shared/components/templates/CommonTemplates";
import LotteryHistoryItem from "./LotteryHistoryItem";
import {Link} from "react-router-dom";

// import { ModuleState } from "modules/lottery-history/types";
import {GameWinningNumberAJAXPaging, GetGameSettingAJAXResponse} from "type/api";
import classNames from "classnames";
import moment from "moment";
import usePagination from "modules/shared/hooks/usePagination";
import LotteryInfoHeader from "modules/shared/components/molecular/LotteryInfoHeader";
import {GALotteryHistoryPage} from "modules/shared/utils/GoogleAnalyticsHelper";

interface ComponentProps {
    history: GameWinningNumberAJAXPaging | undefined;
    gameSetting: GetGameSettingAJAXResponse | undefined;
}

export const HistoryPage: FunctionComponent<ComponentProps> = (props: ComponentProps) => {
    // Assignments to the 'dataSize' variable from inside React Hook useMemo will be lost after each render.
    // To preserve the value over time, store it in a useRef Hook and keep the mutable value in the '.current' property.
    const refDataSize = useRef(0);
    // useEffect 導致數量跟更新但無重新渲染, 因為順序在後面
    useMemo(() => {
        if (!props.history || !props.history.gameWinningNumbers) {
            return;
        }
        const count = props.history.gameWinningNumbers.length;
        refDataSize.current = count;
    }, [props.history]);

    const {pageCount, currentPageNumber, setCurrentPageNumber, startItemNumber, endItemNumber} = usePagination(refDataSize.current, 20);

    // PaginationList
    const memoizedPaginationList = useMemo(() => {
        const components: React.ReactElement[] = [];
        const hasData = pageCount > 0;
        if (hasData) {
            Array.from(Array(pageCount).keys()).forEach((obj, index) => {
                const pageNumber = index + 1;
                // Default 10 pages
                if (pageNumber > 10) {
                    return null;
                }
                components.push(
                    <li
                        key={index}
                        className={classNames({active: pageNumber === currentPageNumber})}
                        onClick={() => {
                            setCurrentPageNumber(pageNumber);
                        }}
                    >
                        {pageNumber}
                    </li>
                );
            });
        }
        return components;
    }, [pageCount, currentPageNumber, setCurrentPageNumber]);

    // LotteryHistoryItems
    const memoizedLotteryHistoryList = useMemo(() => {
        const components: React.ReactElement[] = [];

        if (!props.history || !props.history.gameWinningNumbers || !props.gameSetting) {
            return;
        }

        props.history.gameWinningNumbers.slice(startItemNumber, endItemNumber).forEach((issueData, index) => {
            // string to utc
            const dateTimeUTC = moment.utc(issueData.winningTime);
            // offset
            const date8Zone = dateTimeUTC.utcOffset(8 * 60);
            // format
            const date = date8Zone.format("YYYY-MM-DD HH:mm");
            components.push(<LotteryHistoryItem key={index} date={date} issueNumber={issueData.numero} number={issueData.winningNumbers} originalNumber={issueData.original} showOriginal={props.gameSetting && props.gameSetting.showOriginal} />);
        });
        return components;
    }, [props.history, startItemNumber, endItemNumber, props.gameSetting]);

    if (!props.gameSetting) {
        return null;
    }

    if (!props.history || !props.gameSetting) {
        return null;
    }

    return (
        <CommonTemplates>
            <div className="sub-bg">
                <div className="container">
                    <div className={classNames("lottery-list-wrapper", {keno: props.gameSetting.ballCount >= 20})}>
                        <div className="open-lottery">
                            <LotteryInfoHeader lotteryName={props.gameSetting.displayName} lastIssue={props.history.gameWinningNumbers[0]} logoUrl={props.gameSetting.logoUrl} />

                            <div className="lottery-btn">
                                <Link
                                    to={{
                                        pathname: "/lotteryInfo/" + props.gameSetting.gameCode,
                                    }}
                                    onClick={() => {
                                        if (props.gameSetting) {
                                            GALotteryHistoryPage.eventTriggerIntroduction(props.gameSetting.gameCode);
                                        }
                                    }}
                                >
                                    <div className="more-btn info-btn">彩种介绍</div>
                                </Link>

                                {props.gameSetting.referenceUrl && (
                                    <div
                                        className="more-btn"
                                        onClick={() => {
                                            if (props.gameSetting) {
                                                GALotteryHistoryPage.eventTriggerValidation(props.gameSetting.gameCode);
                                                window.open(String(props.gameSetting.referenceUrl));
                                            }
                                        }}
                                    >
                                        奖源验证
                                    </div>
                                )}
                            </div>
                        </div>
                        <div className="lottery-award-content">
                            <h3>历史奖号</h3>
                            <div className="lottery-list-content">
                                <ul className="award-list">
                                    <li className="list-head">
                                        <div>时间</div>
                                        <div>期数</div>
                                        <div className="award-num">奖号</div>
                                        {/* 是否顯示原始數據 */}
                                        {props.gameSetting.showOriginal && <div>原始数据</div>}
                                    </li>
                                    {memoizedLotteryHistoryList}
                                </ul>
                                <div className="pagination">
                                    <ul>{memoizedPaginationList}</ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </CommonTemplates>
    );
};

export default HistoryPage;
