import {Module, register} from "core-fe";
import {ModuleState} from "./types";
import AboutPage from "./components/AboutPage";

class AboutModule extends Module<ModuleState> {}

const initialModuleState: ModuleState = {};
const moduleInstance = new AboutModule("aboutModule", initialModuleState);
const aboutModule = register(moduleInstance);

export const actions = aboutModule.getActions();
export const AboutPageComponent = aboutModule.attachLifecycle(AboutPage);
