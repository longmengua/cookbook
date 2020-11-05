import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initHeaderFolderExampleState, HeaderFolderExampleProps, HeaderFolderExampleState} from "./interface";
import HeaderFolder from "../../widget/HeaderFolder";

// Import icon from "../../../asset/dashboard/ic_sleep_dashboard@2x.png";
/**
 * Collapse and expand the children by icon
 * */
const HeaderFolderExample: React.FC<HeaderFolderExampleProps> = (props: HeaderFolderExampleProps) => {
	const [
		state,
		setState 
	] = useState(initHeaderFolderExampleState as HeaderFolderExampleState);
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
		<div className={"HeaderFolderExample"}>
			<HeaderFolder imgPath={'../../../asset/dashboard/ic_sleep_dashboard@2x.png'} >
				<div className="parent">
					Many different text. Many different text. Many different text. Many different text. Many
					different text. Many different text. Many different text. Many different text. Many
					different text. Many different text. Many different text. Many different text. Many
					different text. Many different text. Many different text. Many different text. Many
					different text. Many different text. Many different text. Many different text. Many
					different text. Many different text. Many different text. Many different text. Many
					different text. Many different text. Many different text. Many different text. Many
				</div>
			</HeaderFolder>
		</div>
	);
};

export default HeaderFolderExample;
