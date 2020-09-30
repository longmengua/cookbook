import "./index";
import "./index_c";
import * as React from "react";
import {useEffect, useState} from "react";
import {initTemplateState, TemplateProps, TemplateState} from "./interface";

const Template: React.FC<TemplateProps> = (props: TemplateProps) => {
	const [state, setState] = useState(initTemplateState as TemplateState);
	useEffect(()=>{
		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * the function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);
	return (
		<div className={"Template"}>
			<div className="sass">
				Sass
			</div>
			<div className="css">
				Pure Css
			</div>
		</div>
	);
};

export default Template;
