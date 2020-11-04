import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initCarouselState, CarouselProps, CarouselState} from "./interface";

const Carousel: React.FC<CarouselProps> = (props: CarouselProps) => {
	const [
		state,
		setState 
	] = useState(initCarouselState as CarouselState);
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
		<div className={"Carousel"}>
			test
		</div>
	);
};

export default Carousel;
