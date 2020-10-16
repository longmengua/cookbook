import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initDashboardState, DashboardProps, DashboardState} from "./interface";
import InputContainer from "../Util";

const Dashboard: React.FC<DashboardProps> = (props: DashboardProps) => {
	const [state, setState] = useState(initDashboardState as DashboardState);
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
		<div className={"Dashboard"}>
			<InputContainer labelName={"Name"}/>
		</div>
	);
};

export default Dashboard;
