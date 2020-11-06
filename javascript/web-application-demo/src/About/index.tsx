import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initAboutState, AboutProps, AboutState} from "./interface";
import withRedux from "../withRedux";

const About: React.FC<AboutProps> = (props: AboutProps) => {
	const [
		state,
		setState 
	] = useState(initAboutState as AboutState);
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
		<div className={"About"}>
			test
		</div>
	);
};

export default withRedux(About);
