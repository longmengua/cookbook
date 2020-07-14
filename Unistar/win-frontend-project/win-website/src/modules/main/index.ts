import {Module, register, Lifecycle, call} from "core-fe";
import {SagaIterator} from "redux-saga";
import ApplicationRouter from "./components/ApplicationRouter";
import {ModuleState} from "./types";
import {Location} from "history";
import {GameSettingAJAXWebService} from "services/GameSettingAJAXWebService";
import {GetGameSettingAJAXs} from "type/api";

const initialModuleState: ModuleState = {
    gameSetting: null,
};
class MainModule extends Module<ModuleState> {
    @Lifecycle()
    public *onEnter(): SagaIterator {
        // console.log("[MainModule] onEnter", this)
    }
    @Lifecycle()
    public *onRender(routeParameters: {}, location: Location): SagaIterator {
        // console.log("[MainModule] onRender", this)
        // NOTE:
        // 1. work but eslint error
        // yield this.loadGameSettings();
        // 2.
        // this.loadGameSettings();
    }
    public *loadGameSettings(): SagaIterator {
        // console.log("[MainModule] loadGameSettings");
        const response: GetGameSettingAJAXs = yield call(GameSettingAJAXWebService.getAll);
        this.setState({
            gameSetting: response.values,
        });
    }
}

// FIX module redeclared, module => mainMoudle
const mainMoudle = register(new MainModule("main", initialModuleState));
export const Main = mainMoudle.attachLifecycle(ApplicationRouter);
export const actions = mainMoudle.getActions();
