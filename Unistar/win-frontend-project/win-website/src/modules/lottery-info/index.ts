import {Module, register} from "core-fe";
import {Lifecycle, call, Interval} from "core-fe";
import {ModuleState} from "./types";
import LotteryInfoPage from "./components/LotteryInfoRootComponent";
import {SagaIterator} from "redux-saga";
import {SearchWinningNumberAJAXRequest, GetGameSettingAJAXResponse} from "type/api";
import {GameWinningNumberAJAXWebService} from "services/GameWinningNumberAJAXWebService";
import {Location} from "history";
import {GameSettingAJAXWebService} from "services/GameSettingAJAXWebService";

const initialModuleState: ModuleState = {
    isNeedToFetchHistoryList: false,
};

class LotteryInfoModule extends Module<ModuleState> {
    @Lifecycle()
    public *onEnter(): SagaIterator {
        // console.info("[LotteryInfoModule] onEnter", this);
        const gameCode = location.pathname.split("/")[2];
        this.setState({
            gameCode,
        });
        // this.checkAppGameSetting();
        // this.loadHistory();
        // this.loadCurrentGameSetting();
    }
    @Lifecycle()
    public *onRender(routeParameters: {}, location: Location): SagaIterator {}
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
            const response: any = yield call(GameWinningNumberAJAXWebService.searchWinningNumber, request);
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
const moduleInstance = new LotteryInfoModule("lotteryInfoModule", initialModuleState);
const lotteryInfoModule = register(moduleInstance);
export const actions = lotteryInfoModule.getActions();
export const LotteryInfoPageComponent = lotteryInfoModule.attachLifecycle(LotteryInfoPage);
