import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initWithRouterState, WithRouterComponents, WithRouterProps, WithRouterState} from "./interface";
import {BrowserRouter, Switch} from "react-router-dom";
import Path from "./Path";

const WithRouter: WithRouterComponents & React.FC<WithRouterProps> = (props: WithRouterProps) => {
	const [
		state,
		setState 
	] = useState(initWithRouterState as WithRouterState);
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
		<div className={"WithRouter"}>
			<BrowserRouter>
				<Switch>{props.children}</Switch>
			</BrowserRouter>
		</div>
	);
};

WithRouter.Path = Path;

export default WithRouter;
