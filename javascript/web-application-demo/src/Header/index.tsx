import "./index";
import "./index_c";
import * as React from "react";
import {useEffect, useState} from "react";
import {initHeaderState, HeaderProps, HeaderState} from "./interface";
import {Link} from "react-router-dom";

const Header: React.FC<HeaderProps> = (props: HeaderProps) => {
	const [state, setState] = useState(initHeaderState as HeaderState);
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
		<ul>
			<li>
				<Link to="/">Home</Link>
			</li>
			<li>
				<Link to="/about">About</Link>
			</li>
			<li>
				<Link to="/users">Users</Link>
			</li>
		</ul>
	);
};
const shouldUpdate = (prevProps: any, nextProps: any) => false;
export default React.memo(Header, shouldUpdate);
// export default React.memo(Header);
