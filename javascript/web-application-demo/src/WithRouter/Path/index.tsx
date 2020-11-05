import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initPathState, PathProps, PathState} from "./interface";
import {Route} from "react-router-dom";

const Path: React.FC<PathProps> = (props: PathProps) => {
	const [
		state,
		setState 
	] = useState(initPathState as PathState);
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
		<Route path={props.path}>{props.component}</Route>
	);
};

export default Path;
