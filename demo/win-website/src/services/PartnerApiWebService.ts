import {SearchDailyNumerosApiResponse, GameWinningNumberApiResponse} from "type/api";
import {ajax} from "core-fe";

export class PartnerApiWebService {
    static fetchDailyNumeros(gameCode: string, date: string): Promise<SearchDailyNumerosApiResponse> {
        return ajax("GET", "/api/game-numero/:gameCode/date/:date", {gameCode, date}, null);
    }
    static fetchWinningNumber(gameCode: string, numero: string): Promise<GameWinningNumberApiResponse> {
        return ajax("GET", "/api/winning-number/:gameCode/numero/:numero", {gameCode, numero}, null);
    }
}
