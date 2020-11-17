import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initButtonContainerState, ButtonContainerProps, ButtonContainerState} from "./interface";

const ButtonContainer: React.FC<ButtonContainerProps> = (props: ButtonContainerProps) => {

	const [
		state,
		setState 
	] = useState(initButtonContainerState as ButtonContainerState);

	useEffect(()=>{

		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * The function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);

	const onClick = () => {
		alert('clicked');
		props.onClick && props.onClick();
	};

	return (
		<div className={"ButtonContainer"}>
			<div className={'Button'} onClick={()=>onClick()}>Button</div>
		</div>
	);
};

export default ButtonContainer;
