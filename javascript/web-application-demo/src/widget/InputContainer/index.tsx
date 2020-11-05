import "./index.sass";
import * as React from "react";
import {useEffect, useState} from "react";
import {initUtilState, UtilProps, UtilState} from "./interface";

const InputContainer: React.FC<UtilProps> = (props: UtilProps) => {
	const [
		state,
		setState 
	] = useState(initUtilState as UtilState);
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
		<div className={"InputContainer"}>
			<input type="text"/>
			<label>{props.labelName}</label>
		</div>
	);
};

export default InputContainer;
