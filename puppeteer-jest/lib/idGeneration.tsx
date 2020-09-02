const generationOfTWDID = () => {
    // 建立字母分數陣列(A~Z)
    const city = [1, 10, 19, 28, 37, 46, 55, 64, 39, 73, 82, 2, 11,
        20, 48, 29, 38, 47, 56, 65, 74, 83, 21, 3, 12, 30];
    // 建立隨機身份證碼
    const id = [];
    id[0] = String.fromCharCode(Math.floor(Math.random() * (26)) + 65);
    id[1] = Math.floor(Math.random() * (2)) + 1;
    for (let i=2; i<9; i++) {
        id[i] = Math.floor(Math.random() * (9)) + 0;
    }
    // 計算總分
    let total = city[id[0].charCodeAt(0)-65];
    for (let i=1; i<=8; i++) {
        total += eval(id[i] as string) * (9 - i);
    }
    // 計算最尾碼
    const totalArr: string[] = (total+"").split("");
    const lastChar = eval(JSON.stringify(10 - Number(totalArr[totalArr.length-1])));
    const lastCharArr = (lastChar+"").split("");
    // 補上最後檢查碼
    id[id.length++] = lastCharArr[lastCharArr.length-1];
    // 回傳結果
    return id.join("");
};
export default generationOfTWDID;
