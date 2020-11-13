export interface UserInterface {
    name: string;
    password: string;
    email: string;
    qq: string;
}

export class User {
    _name: string;

    _password: string;

    _email: string;

    _qq?: string;

    constructor(config: UserInterface) {
    	this._name = config.name;
    	this._password = config.password;
    	this._email = config.email;
    	if (typeof config.qq !== "undefined") this._qq = config.qq;
    }

    set name(name: string) {
    	// REFACTORING: UI 那邊需要用 blur 清除，因為 name 在 UI 那邊會不給輸入
    	// 錯誤訊息
    	let errorMessage = "";
    	if (name == "") {
    		// NOTE: 超過 32 個字串時候，此訊息不顯示。只顯示為空時候
    		errorMessage = "取款人姓名不能为空且长度不能超过32位！";
    		if (name.length < 32) this._name = name;
    	} else if (/[Ａ-Ｚａ-ｚ．]+/.test(name)) {
    		errorMessage = "输入格式错误，请输入半角！";
    		this._name = name;
    	} else if (!/^[A-Za-z.\u4e00-\u9eff]+$/.test(name)) {
    		errorMessage = "取款人姓名格式不符！";
    	}
    	if (errorMessage !== "") {
    		throw new Error(errorMessage);
    	}
    	this._name = name;
    }

    get name() {
    	return this._name;
    }

    set password(password: string) {
    	const fullWidthPasswordCharacters = password.replace(
    		/[^１-９Ａ-Ｚａ-ｚ，．：；！？＂＇｀＾～￣＿＆＠＃％＋－＊＝＜＞（）［］｛｝｟｠｜￤／＼￢＄￡￠￦￥]+/g,
    		""
    	);
    	let errorMessage = "";
    	if (fullWidthPasswordCharacters != "") {
    		// 长度必须在8到16个字符之间
    		errorMessage = "输入格式错误，请输入半角。";
    		this._password = password;
    	} else if (!/^.{8,}$/.test(password)) {
    		// 长度必须在8到16个字符之间
    		errorMessage = "长度必须在8到16个字符之间";
    		this._password = password;
    	} else if (!/^.{8,16}$/.test(password)) {
    		// 长度必须在8到16个字符之间
    		errorMessage = "长度必须在8到16个字符之间";
    	} else if (!/^\w+$/.test(password)) {
    		// 只能输入字母及数字
    		errorMessage = "只能输入字母及数字";
    		this._password = password;
    	} else if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{2,}$/.test(password)) {
    		// 密码必须包含至少一个数字及一个英文字母组成
    		errorMessage = "密码必须包含至少一个数字及一个英文字母组成";
    		this._password = password;
    	}

    	if (errorMessage !== "") {
    		throw new Error(errorMessage);
    	}
    	// NOTICE: 需等沒錯誤才 Assign
    	this._password = password;
    }

    get password() {
    	return this._password;
    }

    set email(email: string) {
    	let errorMessage = "";
    	const fullWidthEmailCharacters = email.replace(
    		/[^１-９Ａ-Ｚａ-ｚ，．：；！？＂＇｀＾～￣＿＆＠＃％＋－＊＝＜＞（）［］｛｝｟｠｜￤／＼￢＄￡￠￦￥]+/g,
    		""
    	);
    	if (fullWidthEmailCharacters != "") {
    		errorMessage = "输入格式错误，请输入半角。";
    		this._email = email;
    	} else if (!/^[\w]+@\w+.\w+$/.test(email)) {
    		errorMessage = "Email格式不符。";
    		this._email = email;
    	}
    	if (errorMessage !== "") {
    		throw new Error(errorMessage);
    	}
    	this._email = email;
    }

    get email() {
    	return this._email;
    }

    set qq(qq: string) {
    	const fullWidthQQCharacters = qq.replace(/[^１-９]+/g, "");
    	let errorMessage = "";

    	if (fullWidthQQCharacters != "") {
    		errorMessage = "输入格式错误，请输入半角。";
    		this.qq = qq;
    	} else if (!/^[1-9][0-9]{4,}$/.test(qq)) {
    		errorMessage = "QQ碼格式不符。";
    		this._qq = qq;
    	} else if (qq.length > 10) {
    		// 不允許超過 10 位數
    		return;
    	}
    	// console.log("errorMessage", errorMessage);
    	if (errorMessage !== "") {
    		throw new Error(errorMessage);
    	}
    	// NOTICE: 需等沒錯誤才 Assign
    	this._qq = qq;
    }

    get qq() {
    	return this._qq ? this._qq : "";
    }

    json() {
    	return {
    		name    : this.name,
    		password: this.password,
    		email   : this.email,
    		qq      : this.qq,
    	};
    }
}
