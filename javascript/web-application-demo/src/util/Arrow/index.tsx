import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initArrowState, ArrowProps, ArrowState} from "./interface";

const Arrow: React.FC<ArrowProps> = (props: ArrowProps) => {
	const [
		state,
		setState 
	] = useState(initArrowState as ArrowState);
	useEffect(()=>{

		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * The function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);

	/**
	 * Fill means that you wanna fill color in the area, with none will be just line path.
	 * fill:"none" -> line
	 * fill:"" -> fill up with color
	 * */
	return (
		<div className={"Arrow"}>
			<svg viewBox="0 0 100 100" style={{transform: `rotate(${props.rotateDeg || 0}deg)`}}>
				<polyline style={{fill: "",stroke: "black",strokeWidth: "10"}} points="20,10 80,50 20,90"/>
				Sorry, your browser does not support inline SVG.
			</svg>
		</div>
	);
};

export default Arrow;
