import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initDashboardState, DashboardProps, DashboardState} from "./interface";
import InputContainer from "../widget/InputContainer";
import Area from "../widget/Area";
import InputContainer1 from "../widget/InputContainer1";
import SquareRotation from "../widget/SquareRotation";
import Carousel from "../widget/Carousel";
import ScrollBarExample from "../dashboardDetails/ScrollBarExample";
import HeaderFolderExample from "../dashboardDetails/HeaderFolderExample";
import StarRatingAnimation from "../widget/StarRatingAnimation";
import ToolTipContainer from "../widget/ToolTipContainer";
import ButtonContainer from "../widget/ButtonContainer";
import ToolTipContainer1 from "../widget/ToolTipContainer1";

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
			<Area title={"Text Inputs"}>
				<InputContainer labelName={"Name"}/>
				<InputContainer1 labelName={"Name"}/>
			</Area>
			<Area title={"Buttons"}>
				<ButtonContainer />
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
			<Area title={"Header Collapse"} isExpand={false}>
				<HeaderFolderExample />
			</Area>
			<Area title={"Star Rating"} isExpand={false}>
				<StarRatingAnimation />
			</Area>
			<Area title={"ToolTips"} isExpand={true}>
				<ToolTipContainer />
				<ToolTipContainer1 />
			</Area>
		</div>
	);
};

export default Dashboard;
