import * as CoreFE from "core-fe";
import {SagaIterator} from "redux-saga";
import {SearchWinningNumberAJAXRequest, GameWinningNumberAJAXPaging, GetGameSettingAJAXResponse, GetGameSettingAJAXs} from "type/api";
import {GameWinningNumberAJAXWebService} from "services/GameWinningNumberAJAXWebService";
import LotteryHistoryPage from "./components/RootComponent";
import {ModuleState} from "./types";
import {Location} from "history";
import {Lifecycle, Interval} from "core-fe";
import {GameSettingAJAXWebService} from "services/GameSettingAJAXWebService";

const initialModuleState: ModuleState = {
    isNeedToFetchCurrentIssue: false,
    isNeedToFetchHistoryList: false,
};

class LotteryHistoryModule extends CoreFE.Module<ModuleState> {
    @Lifecycle()
    public *onRender(routeParameters: {}, location: Location): SagaIterator {
        const gameCode = location.pathname.split("/")[2];
        this.setState({
            gameCode,
        });
        // yield* this.loadHistory();
        // yield* this.loadCurrentGameSetting();
    }
    // public *loadCurrentGameSetting(): SagaIterator {
    //     const app = this.rootState.app as any;
    //     const filterCurrentGameSetting = app.main.gameSetting.filter((game: GetGameSettingAJAXResponse) => {
    //         return game.gameCode === this.state.gameCode;
    //     });
    //     const currentGameSetting = (filterCurrentGameSetting && filterCurrentGameSetting[0]) || [];
    //     this.setState({
    //         currentIssue: currentGameSetting,
    //     });
    // }
    public *loadCurrentGameSetting(): SagaIterator {
        const app = this.rootState.app as any;
        // console.log("app", app)
        let appResponse: GetGameSettingAJAXs = {values: []};
        if (app.main && app.main.gameSetting === null) {
            appResponse = yield CoreFE.call(GameSettingAJAXWebService.getAll);
        }
        const gameSetting = app.main.gameSetting || appResponse.values;

        const filterCurrentGameSetting = gameSetting.filter((game: GetGameSettingAJAXResponse) => {
            return game.gameCode === this.state.gameCode;
        });
        const currentGameSetting = (filterCurrentGameSetting && filterCurrentGameSetting[0]) || [];
        this.setState({
            currentIssue: currentGameSetting,
        });
    }
    public *loadHistory(): SagaIterator {
        const gameCode = this.state.gameCode || "gameCode";
        try {
            this.setState({
                isNeedToFetchHistoryList: true,
            });
            const request: SearchWinningNumberAJAXRequest = {
                gameCode,
                pageSize: 10,
                pageNumber: 10,
            };
            const response: GameWinningNumberAJAXPaging = yield CoreFE.call(GameWinningNumberAJAXWebService.searchWinningNumber, request);
            const stop = response.gameWinningNumbers[0].winningNumbers && response.gameWinningNumbers[0].winningNumbers.length > 0;

            this.setState({
                historyList: response,
            });

            if (stop) {
                this.setState({
                    isNeedToFetchHistoryList: false,
                });
            }
        } catch (event) {
            // console.info("[catch] event", event);
        }
    }

    @Lifecycle()
    @Interval(10)
    public *onTick(): SagaIterator {
        if (this.state.isNeedToFetchHistoryList) {
            this.loadHistory();
        }
    }
}
// NOTICE: ModuleName must lower case, typescirpt lint 會提示小寫選項，而不是實際大寫
// const module = CoreFE.register(new LotteryHistoryModule("LotteryHistoryModule", initialModuleState))
const lotteryHistoryModule = CoreFE.register(new LotteryHistoryModule("lotteryHistoryModule", initialModuleState));

// Actions
export const actions = lotteryHistoryModule.getActions();

// Component
export const LotteryHistoryComponent = lotteryHistoryModule.attachLifecycle(LotteryHistoryPage);
