import Decimal from "decimal.js";

const formatMoney = (money) => money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

const formatMarketCap = (num, digits) => {
	const si = [
		{ value: 1, symbol: "" },
		{ value: 1E3, symbol: " k" },
		{ value: 1E6, symbol: " M" },
		{ value: 1E9, symbol: " G" },
		{ value: 1E12, symbol: " T" },
		{ value: 1E15, symbol: " P" },
		{ value: 1E18, symbol: " E" }
	];
	const rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
	let i;
	for (i = si.length - 1; i > 0; i--) {
		if (num >= si[i].value) {
			break;
		}
	}
	return (num / si[i].value).toFixed(digits).replace(rx, "$1") + si[i].symbol;
};

const formatPercentage = (num, digits, basicNumber) => {
	const baseNum = basicNumber ? basicNumber : 100;
	return `${(num*baseNum).toFixed(digits)}`;
};

const getTotalValue = (digital, vaultBalance, stakedBalance, pricePerFullShare) => {
	const result = (Math.trunc((vaultBalance + stakedBalance) * pricePerFullShare*10**digital)/10**digital);
	return isNaN(result) ? Number(0).toFixed(digital) : result.toFixed(digital);
};

const getAccurateAmountWithDigit = (balance, digit, toString) => {
	let toReturn;
	const defaultDigit = digit || 4;
	try{
		const _balance = Math.trunc((balance || 0)*10**defaultDigit);
		const amount = new Decimal(_balance).dividedBy(10**defaultDigit);

		isNaN(_balance) ? (toReturn = 0) : (toReturn = amount.toNumber());
	}catch (e) {
		console.error(e);
	}
	return toString ? toReturn.toFixed(defaultDigit).padEnd(defaultDigit, "0") : toReturn;
};

const validateBalance = (balance) => /^[0-9]*(.[0-9]*)?$/.test(balance);

const formatBalanceString = (balanceString, digit) => {
	const digitDefault = digit || 6;
	let toReturn = "0";
	try {
		if(balanceString !== "" && validateBalance(balanceString)){
			const commaIndex = balanceString.indexOf(".");
			const number = balanceString.substr(0, commaIndex);
			digitDefault > 0 && (toReturn = number + balanceString.substr(commaIndex, digitDefault + 1));
		} else {
			toReturn.padEnd(1, ".");
			toReturn.padEnd(digitDefault, "0");
		}
	} catch (e) {
		toReturn.padEnd(1, ".");
		toReturn.padEnd(digitDefault, "0");
	}
	return toReturn;
};

export {
	formatMoney,
	formatMarketCap,
	formatPercentage,
	getAccurateAmountWithDigit,
	getTotalValue,
	validateBalance,
	formatBalanceString
};