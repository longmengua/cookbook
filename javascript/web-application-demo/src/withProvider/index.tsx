import * as React from "react";
import {useEffect, useState} from "react";
import {
	initwithProviderState,
	withProviderProps,
	withProviderState
} from "./interface";
import { Provider } from "react-redux";
import { createStore } from "redux";
import reducer from "./reducer";

const withProvider: React.FC<withProviderProps> = (props: withProviderProps) => {
	const [
		state,
		setState 
	] = useState(initwithProviderState as withProviderState);
	useEffect(()=>{

		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * The function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);
	return (
		<div className={"withProvider"}>
			<Provider store={createStore(reducer)}>
				{props.children}
			</Provider>
		</div>
	);
};

export default withProvider;
