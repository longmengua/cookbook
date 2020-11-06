import * as React from "react";
import {useEffect, useState} from "react";
import {
	initwithReduxState,
	withReduxState
} from "./interface";
import { Provider } from "react-redux";
import { createStore } from "redux";
import reducer from "./reducer";

const withRedux: (props: React.ComponentType<any>) => any = (props) => {
	return (
		<div className={"withRedux"}>
			<Provider store={createStore(reducer)}>
				{props}
			</Provider>
		</div>
	);
};

export default withRedux;
