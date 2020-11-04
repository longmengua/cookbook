import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initHeaderFolderState, HeaderFolderProps, HeaderFolderState} from "./interface";
import Arrow from "../Arrow";

const HeaderFolder: React.FC<HeaderFolderProps> = (props: HeaderFolderProps) => {
	const [state, setState] = useState(initHeaderFolderState as HeaderFolderState);
	useEffect(()=>{
		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		setState({...state, isExpanded: !!props.isExpanded});
		/**
		 * the function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, [props.isExpanded]);
	return (
		<div className={`HeaderFolder ${state.isExpanded ? 'isExpanded' : ''}`}>
			{/*<input type="checkbox" name="rating" id="rating-5" />*/}
			{/*<label htmlFor="rating-5" />*/}
			<div className={"content"}>{props.children}</div>
		</div>
	);
};

export default HeaderFolder;
