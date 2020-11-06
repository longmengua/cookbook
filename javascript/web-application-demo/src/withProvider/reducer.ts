import {initwithProviderState, withProviderAction, withProviderActionTypes, withProviderState} from "./interface";

const reducer = (
	state: withProviderState = initwithProviderState,
	action: withProviderAction
): withProviderState => {
	let toReturn = state;
	switch (action.type) {
	case withProviderActionTypes.Create:
		toReturn = {...state};
		break;
	case withProviderActionTypes.Read:
		toReturn = {...state};
		break;
	case withProviderActionTypes.Update:
		toReturn = {...state};
		break;
	case withProviderActionTypes.Delete:
		toReturn = {...state};
		break;
	}
	console.log("reducer > ", toReturn);
	return toReturn;
};

export default reducer;