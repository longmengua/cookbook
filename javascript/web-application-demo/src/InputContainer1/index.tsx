import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initInputContainer1State, InputContainer1Props, InputContainer1State} from "./interface";

const InputContainer1: React.FC<InputContainer1Props> = (props: InputContainer1Props) => {
	const [
		state,
		setState 
	] = useState(initInputContainer1State as InputContainer1State);
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
		<div className={"InputContainer1"}>
			<input type="text" placeholder={" "}/>
			<label>{props.labelName}</label>
		</div>
	);
};

export default InputContainer1;
