import {Module, register} from "core-fe";
import {ModuleProxy} from "core-fe/lib/platform/ModuleProxy";
import HomePage from "./components/HomeRootComponent";
import {SagaIterator} from "redux-saga";
import {Lifecycle} from "core-fe";
import {Location} from "history";

interface ModuleState {}

const initialModuleState: ModuleState = {};

class HomeModule extends Module<ModuleState> {
    @Lifecycle()
    public *onRender(routeParameters: {}, location: Location): SagaIterator {
        // console.info("[HomeModule]onRender", location);
    }
}

const moduleInstance = new HomeModule("homeModule", initialModuleState);
const homeModule: ModuleProxy<HomeModule> = register(moduleInstance);

export const actions = homeModule.getActions();
export const HomePageComponent = homeModule.attachLifecycle(HomePage);
