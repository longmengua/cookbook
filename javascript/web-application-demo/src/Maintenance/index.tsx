import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initMaintenanceState, MaintenanceProps, MaintenanceState} from "./interface";
import {render} from "react-dom";

const Maintenance: React.FC<MaintenanceProps> = (props: MaintenanceProps) => {
	const [
		state,
		setState 
	] = useState(initMaintenanceState as MaintenanceState);
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
		<div className={"Maintenance"}>
			test
		</div>
	);
};

export default Maintenance;

render(
	<React.StrictMode>
		<Maintenance />
	</React.StrictMode>,
	document.getElementById('root_react')
);