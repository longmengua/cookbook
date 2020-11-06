import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initHomeState, HomeProps, HomeState} from "./interface";

const Home: React.FC<HomeProps> = (props: HomeProps) => {
	const [
		state,
		setState 
	] = useState(initHomeState as HomeState);
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
		<div className={"Home"}>
			test
		</div>
	);
};

export default Home;
