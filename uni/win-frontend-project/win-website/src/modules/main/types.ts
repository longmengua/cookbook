import {GetGameSettingAJAXResponse} from "type/api";

export interface ModuleState {
    gameSetting: GetGameSettingAJAXResponse[] | null;
}
