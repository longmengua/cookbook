import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initToolTipContainerState, ToolTipContainerProps, ToolTipContainerState} from "./interface";

const ToolTipContainer: React.FC<ToolTipContainerProps> = (props: ToolTipContainerProps) => {

	const [
		state,
		setState 
	] = useState(initToolTipContainerState as ToolTipContainerState);

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
		<div className={"ToolTipContainer"}>
			test
			<div className={"tip"}>Hot</div>
		</div>
	);
};

export default ToolTipContainer;
