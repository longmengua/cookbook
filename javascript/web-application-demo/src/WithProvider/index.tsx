import * as React from "react";
import {useEffect, useState} from "react";
import {
	initWithProviderState,
	WithProviderProps,
	WithProviderState
} from "./interface";
import { Provider } from "react-redux";
import { createStore } from "redux";
import reducer from "./reducer";

const WithProvider: React.FC<WithProviderProps> = (props: WithProviderProps) => {
	const [
		state,
		setState 
	] = useState(initWithProviderState as WithProviderState);
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
		<div className={"WithProvider"}>
			<Provider store={createStore(reducer)}>
				{props.children}
			</Provider>
		</div>
	);
};

export default WithProvider;
