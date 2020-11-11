import * as React from "react";
import {
	initwithReduxState,
	withReduxState,
} from "./interface";
import { Provider } from "react-redux";
import { createStore, applyMiddleware } from "redux";
import reducer from "./reducer";

export const store = createStore(reducer, applyMiddleware());

const withRedux: (props: JSX.Element | React.ReactNode | React.FC | Element) => React.ReactNode = (props) => {
	return (
		<div className={"withRedux"}>
			<Provider store={store}>
				{props}
			</Provider>
		</div>
	);
};

export default withRedux;
