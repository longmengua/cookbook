import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initWithRouterState, WithRouterComponents, WithRouterProps, WithRouterState} from "./interface";
import {HashRouter, Route, Switch} from "react-router-dom";
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

	const route = () => props.routers?.map((o=><Route path={o.path}>{o.component}</Route>));

	return (
		<div className={"WithRouter"}>
			<HashRouter>
				<Switch>
					{route()}
				</Switch>
			</HashRouter>
		</div>
	);
};

// todo: under construction
WithRouter.Path = Path;

export default WithRouter;
