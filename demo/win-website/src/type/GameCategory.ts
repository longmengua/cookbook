import {GameCategoryAJAXResponse, GetGameSettingAJAXResponse} from "./api";

export interface GameCategories {
    gameCategories: GameCategory[];
}
export type GameCategory = GameCategoryAJAXResponse & {
    gameSettings: GetGameSettingAJAXResponse[];
};
