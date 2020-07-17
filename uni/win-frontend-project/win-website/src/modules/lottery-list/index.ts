import {Module, register, call, Lifecycle} from "core-fe";
import {ModuleState} from "./types";
import LotteryListPage from "./components/LotteryListRootComponent";
import {SagaIterator} from "redux-saga";
import {GameCategoryAJAXWebService} from "services/GameCategoryAJAXWebService";
import {GameCategoriesAJAX, GetGameSettingAJAXResponse, GetGameSettingAJAXs} from "type/api";
import {GameCategories} from "type/GameCategory";
import {GameSettingAJAXWebService} from "services/GameSettingAJAXWebService";

const initialModuleState: ModuleState = {};

function getGameSetting(pool: GetGameSettingAJAXResponse[], gameCode: string): GetGameSettingAJAXResponse {
    const gameSetting = pool.filter((game: GetGameSettingAJAXResponse) => {
        return game.gameCode === gameCode;
    });
    return gameSetting[0];
}
class LotteryListModule extends Module<ModuleState> {
    @Lifecycle()
    public *onRender(): SagaIterator {
        // NOTE: Double Check
        // if(!this.state.categoryList) {
        //     yield *this.loadLotteryCategory();
        // }
    }
    public *loadLotteryCategory(): SagaIterator {
        // APP
        const app = this.rootState.app as any;
        // console.log("app", app)

        let appResponse: GetGameSettingAJAXs = {values: []};
        if (app.main && app.main.gameSetting === null) {
            appResponse = yield call(GameSettingAJAXWebService.getAll);
        }

        // Request
        const response: GameCategoriesAJAX = yield call(GameCategoryAJAXWebService.searchCategories);
        const data: GameCategories = {
            gameCategories: [],
        };
        // FIXME:
        const gameSetting = app.main.gameSetting || appResponse.values;

        // Generate View Data
        response.gameCategories.map((category, index) => {
            // gameCategory
            let gameSettingArray = [];
            if (category.gameCodes) {
                const gameSettingArr = category.gameCodes.map(gameCode => gameSetting && gameSetting.length > 0 && gameSetting.filter((game: GetGameSettingAJAXResponse) => game.gameCode === gameCode)[0]);
                // Create game settings
                gameSettingArray = gameSettingArr;
            }
            data.gameCategories[index] = {
                category: category.category,
                displayName: category.displayName,
                gameCodes: category.gameCodes,
                gameSettings: gameSettingArray,
            };
        });
        this.setState({
            categoryList: data.gameCategories,
        });
    }
}
const LotteryListModuleInstance = new LotteryListModule("lotteryListModule", initialModuleState);
const lotteryListModule = register(LotteryListModuleInstance);
export const actions = lotteryListModule.getActions();
export const LotteryListPageComponent = lotteryListModule.attachLifecycle(LotteryListPage);
