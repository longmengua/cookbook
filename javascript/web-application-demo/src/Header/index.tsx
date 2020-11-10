import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initHeaderState, HeaderProps, HeaderState} from "./interface";
import {CustomRouter, routers} from "../index_r";

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

	const links = (routers: Array<CustomRouter> = []) => routers.map(((object, index) =>{
		// todo: @note Empty name or display is false won't show up.
		if (object.display == false || object.name.trim() == "") return;
		return <li key={`header-link-${index}`}>
			<a href={`#${object.path}`}>{object.name}</a>
		</li>;
	}));
	console.log('links', props.routers);
	return (
		<div className={"Header"}>
			<ul>{links(props.routers)}</ul>
		</div>
	);
};
const shouldUpdate = (prevProps: any, nextProps: any) => false;
export default React.memo(Header, shouldUpdate);
// Export default React.memo(Header);
