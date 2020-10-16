import "./index.sass";
import "./index_c.css";
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
		<div className={"Header"}>
			<ul>
				<li>
					<Link to="/">Home</Link>
				</li>
				<li>
					<Link to="/About">About</Link>
				</li>
				<li>
					<Link to="/Users">Users</Link>
				</li>
				<li>
					<Link to="/Dashboard">Dashboard</Link>
				</li>
			</ul>
		</div>
	);
};
const shouldUpdate = (prevProps: any, nextProps: any) => false;
export default React.memo(Header, shouldUpdate);
// export default React.memo(Header);
