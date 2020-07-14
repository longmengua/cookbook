export interface GameCategoriesAJAX {
    gameCategories: GameCategoryAJAXResponse[];
}
export interface GameCategoryAJAXResponse {
    category: string;
    displayName: string;
    gameCodes: string[];
}
export interface SearchDailyNumerosApiResponse {
    gameCode: string;
    numeros: GameNumeroApiResponse[];
}
export interface GameNumeroApiResponse {
    numero: string;
    winningTime: string;
}
export interface GameWinningNumberApiResponse {
    gameCode: string;
    numero: string;
    winningTime: string;
    winningNumber: string;
}
export interface GetGameSettingAJAXs {
    values: GetGameSettingAJAXResponse[] | null;
}
export interface GetGameSettingAJAXResponse {
    gameCode: string;
    gameIntroduction: string;
    logoUrl: string;
    contentUrl: string;
    referenceUrl: string | null;
    referenceContentUrl: string | null;
    showOriginal: boolean;
    displayName: string;
    ballLeftPadSize: number;
    winNoSplittable: boolean;
    ballCount: number;
}
export interface SearchWinningNumberAJAXRequest {
    gameCode: string;
    pageSize: number;
    pageNumber: number;
}
export interface GameWinningNumberAJAXPaging {
    gameWinningNumbers: GameWinningNumberAJAXResponse[];
    pageSize: number;
    pageNumber: number;
}
export interface GameWinningNumberAJAXResponse {
    winningTime: string;
    numero: string;
    winningNumbers: string[] | null;
    original: string | null;
}
export interface AJAXErrorResponse {
    id: string | null;
    errorCode: string | null;
    message: string | null;
}
export interface Bean {}
