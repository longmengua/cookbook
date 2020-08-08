import React, {FunctionComponent, useState, useEffect, useMemo} from "react";
// import "presentation/styles/pages/";
// import "../../styles/pages/lotteryList.scss";
// import "./style.scss";

import CommonTemplates from "modules/shared/components/templates/CommonTemplates";
// import { lotteryList as lotteryListData } from "./dummy/lotteryList"
import LotteryList from "./LotteryList";
import classNames from "classnames";
import usePagination from "modules/shared/hooks/usePagination";

import {range, Observable, Observer} from "rxjs";
// import Paginator from "presentation/hooks/usePaginator/demo/Paginator";
import {GameCategory} from "type/GameCategory";
import {GetGameSettingAJAXResponse} from "type/api";
interface PageProps {
    gameCategories?: GameCategory[];
}
const Page: FunctionComponent<PageProps> = (props: PageProps) => {
    // State
    const [categoryIndex, setCategoryIndex] = useState<number>(0);
    const [category, setCategory] = useState<string>();

    // 當前分類下，總項目
    const [currentCategoryData, setCurrentCategoryData] = useState<GetGameSettingAJAXResponse[]>();

    // 當前分類下，目前分頁中的項目
    // NOTICE: init []
    const [currentLotteryPaginationData, setCurrentLotteryPaginationData] = useState<GetGameSettingAJAXResponse[]>([]);

    // 分頁預設項目總數
    const itemSizePerPage = 15;
    // const dataTotalSize = currentCategoryData ? currentCategoryData.length : 0;
    const currentLotteryCategoryLotteryTotalSize = currentLotteryPaginationData.length;
    const {pageCount, currentPageNumber, setCurrentPageNumber, itemTotalSize, startItemNumber, endItemNumber} = usePagination(currentLotteryCategoryLotteryTotalSize, itemSizePerPage);

    // 分頁切換後
    useEffect(() => {
        const startIndex = startItemNumber > 1 ? startItemNumber - 1 : 0;
        const endIndex = startItemNumber + itemSizePerPage;
        if (props.gameCategories) {
            const finalData: GetGameSettingAJAXResponse[] = props.gameCategories[categoryIndex].gameSettings.slice(startIndex, endIndex);
            // 分頁項目
            setCurrentLotteryPaginationData(finalData);
        }
    }, [currentPageNumber, props.gameCategories]);

    // Effect
    // 初始化資料: [props.gameCategories]
    // do something after render
    useEffect(() => {
        // Invalid hook call. Hooks can only be called inside of the body of a function component.
        // const { pageCount, currentPageNumber, setCurrentPageNumber, itemTotalSize } = usePagination(props.gameCategories);

        if (props.gameCategories && props.gameCategories[0] && props.gameCategories[0].gameSettings[0] !== null) {
            setCategoryIndex(0);
            setCategory(props.gameCategories[0].category);
            // if (startItemNumber) {
            const finalData = props.gameCategories[0].gameSettings.slice(0, itemSizePerPage);
            if (props.gameCategories[0].gameSettings) {
                // 總項目
                setCurrentCategoryData(props.gameCategories[0].gameSettings);

                // 分頁項目
                setCurrentLotteryPaginationData(finalData);
            }
        }
        // Specify how to clean up after this effect:
        return () => {
            // console.info("[Page][useEffect] return props", props)
        };
    }, [props.gameCategories, props.gameCategories && props.gameCategories[0].gameSettings && props.gameCategories[0].gameSettings[0]]);

    useEffect(() => {
        if (startItemNumber) {
            const startIndex = startItemNumber - 1;
            const endIndex = startItemNumber + 15;
            // console.info("[Page] startIndex:", startIndex);
            // console.info("[Page] endIndex:", endIndex);
            if (props.gameCategories) {
                const finalData = props.gameCategories[categoryIndex].gameSettings.slice(startIndex, endIndex);
                console.info("[Page] finalData:", finalData);
                setCurrentLotteryPaginationData(finalData);
                // setCurrentLotteryPaginationData()
            }
        }
    }, [startItemNumber, props.gameCategories]);

    // paginationItem
    const paginationItem: JSX.Element[] = [];
    const pageRange$ = range(1, pageCount);
    pageRange$.subscribe(pageNumber => {
        paginationItem.push(
            <li
                key={pageNumber}
                className={classNames({active: pageNumber === currentPageNumber})}
                onClick={() => {
                    setCurrentPageNumber(pageNumber);
                }}
            >
                {pageNumber}
            </li>
        );
    });
    useEffect(() => {
        // 切換分類要設定資料預設筆數
        if (props.gameCategories) {
            const newCategoryIndex = categoryIndex;
            const finalData = props.gameCategories[newCategoryIndex].gameSettings.slice(0, itemSizePerPage);
            // 分頁項目
            setCurrentLotteryPaginationData(finalData);
        }
    }, [categoryIndex, props.gameCategories]);

    // Compose Component
    // 切換分類項目, 這時候分頁要回復預設值第1頁, 要設定資料預設筆數

    const categoryComponents: JSX.Element[] = useMemo(() => {
        const components: JSX.Element[] = [];
        if (props.gameCategories && props.gameCategories.length > 0) {
            props.gameCategories.forEach((item, index) => {
                components.push(
                    <li
                        key={index}
                        className={classNames({active: item.category === category})}
                        onClick={() => {
                            setCategoryIndex(index);
                            setCategory(item.category);
                            setCurrentLotteryPaginationData(item.gameSettings);

                            // 分頁要回復預設值第1頁
                            setCurrentPageNumber(1);
                            // 切換分類要設定資料預設筆數 => useEffect
                        }}
                    >
                        {item.displayName}
                    </li>
                );
            });
        }
        return components;
    }, [props.gameCategories, category, setCategoryIndex, setCategory, setCurrentLotteryPaginationData, setCurrentPageNumber]);

    return (
        <CommonTemplates>
            <div className="sub-bg">
                <div className="container">
                    {/* <Paginator></Paginator> */}
                    <div className="lottery-list-wrapper">
                        <div className="lottery-list-menu">
                            <ul>{categoryComponents}</ul>
                        </div>
                        <div className="lottery-list-content">
                            <LotteryList data={currentLotteryPaginationData} />
                            <div className="pagination">
                                <ul>{paginationItem}</ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </CommonTemplates>
    );
};

export default Page;
