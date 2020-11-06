import {initwithReduxState, withReduxAction, withReduxActionTypes, withReduxState} from "./interface";

const reducer = (
	state: withReduxState = initwithReduxState,
	action: withReduxAction
): withReduxState => {
	let toReturn = state;
	switch (action.type) {
	case withReduxActionTypes.Create:
		toReturn = {...state};
		break;
	case withReduxActionTypes.Read:
		toReturn = {...state};
		break;
	case withReduxActionTypes.Update:
		toReturn = {...state};
		break;
	case withReduxActionTypes.Delete:
		toReturn = {...state};
		break;
	}
	console.log("reducer > ", toReturn);
	return toReturn;
};

export default reducer;