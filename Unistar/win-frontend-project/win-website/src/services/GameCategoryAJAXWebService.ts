import {GameCategoriesAJAX} from "type/api";
import {ajax} from "core-fe";

export class GameCategoryAJAXWebService {
    static searchCategories(): Promise<GameCategoriesAJAX> {
        return ajax("GET", "/ajax/game-category", {}, null);
    }
}
