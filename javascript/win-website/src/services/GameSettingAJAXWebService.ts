import {GetGameSettingAJAXs} from "type/api";
import {ajax} from "core-fe";

export class GameSettingAJAXWebService {
    static getAll(): Promise<GetGameSettingAJAXs> {
        return ajax("GET", "/ajax/game-setting", {}, null);
    }
}
