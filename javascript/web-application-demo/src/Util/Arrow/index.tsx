import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initArrowState, ArrowProps, ArrowState} from "./interface";

const Arrow: React.FC<ArrowProps> = (props: ArrowProps) => {
	const [state, setState] = useState(initArrowState as ArrowState);
	useEffect(()=>{
		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * the function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);
	/**
	 * fill means that you wanna fill color in the area, with none will be just line path.
	 * */
	return (
		<div className={"Arrow"}>
			<svg viewBox="0 0 100 100">
				<polyline style={{fill:"none",stroke:"black",strokeWidth:"10"}} points="20,10 80,50 20,90"/>
				Sorry, your browser does not support inline SVG.
			</svg>
		</div>
	);
};

export default Arrow;
