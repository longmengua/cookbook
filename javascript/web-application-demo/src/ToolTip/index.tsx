import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initToolTipState, ToolTipProps, ToolTipState} from "./interface";

const ToolTip: React.FC<ToolTipProps> = (props: ToolTipProps) => {

	const [
		state,
		setState 
	] = useState(initToolTipState as ToolTipState);

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
		<div className={"ToolTip"}>
			test<div className={"tip"}>请复制实际充值金额</div>
		</div>
	);
};

export default ToolTip;
