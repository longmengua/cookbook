import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initScrollBarExampleState, ScrollBarExampleProps, ScrollBarExampleState} from "./interface";
import ScrollBar from "../ScrollBar";

const ScrollBarExample: React.FC<ScrollBarExampleProps> = (props: ScrollBarExampleProps) => {
	const [
		state,
		setState 
	] = useState(initScrollBarExampleState as ScrollBarExampleState);
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
		<div className={"ScrollBarExample"}>
			<ScrollBar>
				<div className="wrapper">
					<div id="container">
						<div className="parent">
							<h2>Custom scrollbar</h2>
							Many different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text. Many different text. Many different text. Many
							different text. Many different text.
						</div>
					</div>
				</div>
			</ScrollBar>
		</div>
	);
};

export default ScrollBarExample;
