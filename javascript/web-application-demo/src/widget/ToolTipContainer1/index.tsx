import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initToolTipContainer1State, ToolTipContainer1Props, ToolTipContainer1State} from "./interface";

const ToolTipContainer1: React.FC<ToolTipContainer1Props> = (props: ToolTipContainer1Props) => {

	const [
		state,
		setState 
	] = useState(initToolTipContainer1State as ToolTipContainer1State);

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
		<div className={"ToolTipContainer1"}>
			<div className="tooltip">
				<div className="target">Hover over me</div>
				<div className="tipText tipTop">Top Tooltip text</div>
				<div className="tipText tipLeft">Left Tooltip text</div>
				<div className="tipText tipRight">Right Tooltip text</div>
				<div className="tipText tipBottom">Bottom Tooltip text</div>
			</div>
		</div>
	);
};

export default ToolTipContainer1;
