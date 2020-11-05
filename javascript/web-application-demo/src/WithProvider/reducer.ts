import {initWithProviderState, WithProviderAction, WithProviderActionTypes, WithProviderState} from "./interface";

const reducer = (
	state: WithProviderState = initWithProviderState,
	action: WithProviderAction
): WithProviderState => {
	let toReturn = state;
	switch (action.type) {
	case WithProviderActionTypes.Create:
		toReturn = {...state};
		break;
	case WithProviderActionTypes.Read:
		toReturn = {...state};
		break;
	case WithProviderActionTypes.Update:
		toReturn = {...state};
		break;
	case WithProviderActionTypes.Delete:
		toReturn = {...state};
		break;
	}
	console.log("reducer > ", toReturn);
	return toReturn;
};

export default reducer;