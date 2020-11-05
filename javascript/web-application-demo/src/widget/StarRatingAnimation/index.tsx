import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initStarRatingAnimationState, StarRatingAnimationProps, StarRatingAnimationState} from "./interface";

const StarRatingAnimation: React.FC<StarRatingAnimationProps> = (props: StarRatingAnimationProps) => {
	const [
		state,
		setState 
	] = useState(initStarRatingAnimationState as StarRatingAnimationState);
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
		<div className={"StarRatingAnimation"}>
			<div className="rating">
				<input type="radio" name="rating" id="rating-5" />
				<label htmlFor="rating-5" />
				<input type="radio" name="rating" id="rating-4"/>
				<label htmlFor="rating-4" />
				<input type="radio" name="rating" id="rating-3"/>
				<label htmlFor="rating-3" />
				<input type="radio" name="rating" id="rating-2"/>
				<label htmlFor="rating-2" />
				<input type="radio" name="rating" id="rating-1"/>
				<label htmlFor="rating-1" />
			</div>
		</div>
	);
};

export default StarRatingAnimation;
