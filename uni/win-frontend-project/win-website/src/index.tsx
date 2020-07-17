import "./bootstrap";
import {startApp} from "core-fe";
import {ErrorHandler} from "./modules/shared/ErrorHandler";
import {Main as MainModuleComponent} from "./modules/main";
// console.info("PRODUCTION:", PRODUCTION);
startApp({
    componentType: MainModuleComponent,
    errorListener: new ErrorHandler(),
});
