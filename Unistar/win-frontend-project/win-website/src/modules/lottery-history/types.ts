import {GameWinningNumberAJAXPaging, GetGameSettingAJAXResponse} from "type/api";
import {Subject} from "rxjs";
export const LOADING_PRODUCT_LIST = "product/list";

export interface ModuleState {
    gameCode?: string;
    isNeedToFetchCurrentIssue?: boolean;
    currentIssue?: GetGameSettingAJAXResponse;
    isNeedToFetchHistoryList?: boolean;
    historyList?: GameWinningNumberAJAXPaging;
}
