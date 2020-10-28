import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initSquareRotationState, SquareRotationProps, SquareRotationState} from "./interface";

const SquareRotation: React.FC<SquareRotationProps> = (props: SquareRotationProps) => {
	const [state, setState] = useState(initSquareRotationState as SquareRotationState);
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
		<div className={"SquareRotation"}>
			<div className={"aspect"}/>
			<div className={"aspect"}/>
			{/*<div className={"aspect"}/>*/}
			{/*<div className={"aspect"}/>*/}
			{/*<div className={"aspect"}/>*/}
			{/*<div className={"aspect"}/>*/}
			<div className="container">
				<div className="cube">
					<div className="side front"/>
					<div className="side left"/>
					<div className="side right"/>
					<div className="side back"/>
					<div className="side top"/>
					<div className="side bottom"/>
				</div>
			</div>
		</div>
	);
};

export default SquareRotation;
