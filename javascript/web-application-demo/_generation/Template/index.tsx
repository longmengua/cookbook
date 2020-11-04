import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initTemplateState, TemplateProps, TemplateState} from "./interface";

const Template: React.FC<TemplateProps> = (props: TemplateProps) => {
	const [
		state,
		setState 
	] = useState(initTemplateState as TemplateState);
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
		<div className={"Template"}>
			test
		</div>
	);
};

export default Template;
