import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initReduxState, ReduxProps, ReduxState} from "./interface";
import withRedux from "../withRedux";
import {connect} from "react-redux";
import InputContainer from "../widget/InputContainer";
import InputContainer1 from "../widget/InputContainer1";
import Area from "../widget/Area";

const Redux: React.FC<ReduxProps> = (props: ReduxProps) => {

	const [
		state,
		setState 
	] = useState(initReduxState as ReduxState);

	useEffect(()=>{

		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * The function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);

	// const divElement = connect(<div />);

	return (
		<div className={"Redux"}>
			Redux
			<Area title={"Input"}>
				<InputContainer labelName={"Name"}/>
				<InputContainer1 labelName={"Name"}/>
			</Area>
		</div>
	);
};

export default Redux;
