import {State} from "core-fe";
import {GameWinningNumberAJAXPaging, GameCategoryAJAXResponse, GetGameSettingAJAXResponse} from "./api";

import {Subject} from "rxjs";
import {GameCategory} from "type/GameCategory";

export interface RootState extends State {
    app: {
        main: {
            gameSetting: GetGameSettingAJAXResponse[] | null;
        };
        homeModule: {
            lotteryList?: GetGameSettingAJAXResponse[];
        };
        lotteryListModule: {
            categoryList?: GameCategory[];
        };
        lotteryInfoModule: {
            currentIssue: GetGameSettingAJAXResponse;
            fetchHistoryList: boolean;
            historyList: GameWinningNumberAJAXPaging;
            fetchCurrentIssue: boolean;
        };
        lotteryHistoryModule: {
            currentIssue: GetGameSettingAJAXResponse;
            fetchHistoryList: boolean;
            historyList: GameWinningNumberAJAXPaging;
            fetchCurrentIssue: boolean;
        };
    };
}
