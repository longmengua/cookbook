import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initDashboardState, DashboardProps, DashboardState} from "./interface";
import InputContainer from "../InputContainer";
import Area from "../Area";
import InputContainer1 from "../InputContainer1";
import SquareRotation from "../SquareRotation";
import Carousel from "../Carousel";
import ScrollBar from "../ScrollBar";
import ScrollBarExample from "../ScrollBarExample";

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
			<Area title={"Input"}>
				<InputContainer labelName={"Name"}/>
				<InputContainer1 labelName={"Name"}/>
			</Area>
			<Area title={"3D"}>
				<SquareRotation />
			</Area>
			<Area title={"Scroll bar"}>
				<ScrollBarExample />
			</Area>
			<Area title={"Carousel Ad."}>
				<Carousel />
			</Area>
		</div>
	);
};

export default Dashboard;