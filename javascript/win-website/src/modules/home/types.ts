import {GetGameSettingAJAXResponse} from "type/api";

export interface ModuleState {
    lotteryList?: GetGameSettingAJAXResponse[];
}

export interface FakeLotteryList {
    game_code: string;
    game_introduction: string;
    logo_url: string;
    content_url: string;
    display_name: string;
}
