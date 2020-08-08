import {GameWinningNumberAJAXPaging, GetGameSettingAJAXResponse} from "type/api";
import {Subject} from "rxjs";

export interface ModuleState {
    gameCode?: string;
    isNeedToFetchCurrentIssue?: boolean;
    currentIssue?: GetGameSettingAJAXResponse;
    isNeedToFetchHistoryList?: boolean;
    historyList?: GameWinningNumberAJAXPaging;
}
