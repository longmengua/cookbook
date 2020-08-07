import {Module, register} from "core-fe";
import {ModuleState} from "./types";
import ServicePage from "./components/ServicePage";

class ServiceModule extends Module<ModuleState> {}

const initialModuleState: ModuleState = {};
const moduleInstance = new ServiceModule("serviceModule", initialModuleState);
const serviceModule = register(moduleInstance);

export const actions = serviceModule.getActions();
export const ServicePageComponent = serviceModule.attachLifecycle(ServicePage);
