import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initHeaderState, HeaderProps, HeaderState} from "./interface";
import {Link} from "react-router-dom";

const Header: React.FC<HeaderProps> = (props: HeaderProps) => {
	const [
		state,
		setState 
	] = useState(initHeaderState as HeaderState);
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
		<div className={"Header"}>
			<ul>
				<li>
					<a href="#/">Home</a>
				</li>
				<li>
					<a href="#/about">About</a>
				</li>
				<li>
					<a href="#/dashboard">Dashboard</a>
				</li>
			</ul>
		</div>
	);
};
const shouldUpdate = (prevProps: any, nextProps: any) => 
	false;
export default React.memo(Header, shouldUpdate);
// Export default React.memo(Header);
