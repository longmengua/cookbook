import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initSplashState, SplashProps, SplashState} from "./interface";
import {homePagePath, routers} from "../index_r";

const Splash: React.FC<SplashProps> = (props: SplashProps) => {

	const [
		state,
		setState 
	] = useState(initSplashState as SplashState);

	useEffect(()=>{

		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		setTimeout(()=> {
			//loads a new document
			window.location.assign(homePagePath);
		}, 1000);

		/**
		 * The function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);

	return (
		<div className={"Splash"}>
			Splash
		</div>
	);
};

export default Splash;
