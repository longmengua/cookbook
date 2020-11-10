import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initPageNotFoundState, PageNotFoundProps, PageNotFoundState} from "./interface";

const PageNotFound: React.FC<PageNotFoundProps> = (props: PageNotFoundProps) => {

	const [
		state,
		setState 
	] = useState(initPageNotFoundState as PageNotFoundState);

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
		<div className={"PageNotFound"}>
			PageNotFound
		</div>
	);
};

export default PageNotFound;
