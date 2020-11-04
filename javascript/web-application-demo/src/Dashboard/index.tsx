import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initDashboardState, DashboardProps, DashboardState} from "./interface";
import InputContainer from "../util/InputContainer";
import Area from "../util/Area";
import InputContainer1 from "../util/InputContainer1";
import SquareRotation from "../util/SquareRotation";
import Carousel from "../util/Carousel";
import ScrollBar from "../util/ScrollBar";
import ScrollBarExample from "../example/ScrollBarExample";
import HeaderFolderExample from "../example/HeaderFolderExample";
import StarRatingAnimation from "../util/StarRatingAnimation";

const Dashboard: React.FC<DashboardProps> = (props: DashboardProps) => {
	const [
		state,
		setState 
	] = useState(initDashboardState as DashboardState);
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
			<Area title={"Header Collapse."} isExpand={true}>
				<HeaderFolderExample />
			</Area>
			<Area title={"Star Rating."} isExpand={false}>
				<StarRatingAnimation />
			</Area>
		</div>
	);
};

export default Dashboard;
