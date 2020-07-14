import {SearchWinningNumberAJAXRequest, GameWinningNumberAJAXPaging} from "type/api";
import {ajax} from "core-fe";

export class GameWinningNumberAJAXWebService {
    static searchWinningNumber(request: SearchWinningNumberAJAXRequest): Promise<GameWinningNumberAJAXPaging> {
        return ajax("GET", "/ajax/game-winning-number", {}, request);
    }
}
