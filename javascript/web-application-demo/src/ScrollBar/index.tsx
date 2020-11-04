import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useState} from "react";
import {initScrollBarState, ScrollBarProps, ScrollBarState} from "./interface";

const ScrollBar: React.FC<ScrollBarProps> = (props: ScrollBarProps) => {
	const wrapper = React.createRef<HTMLDivElement>();
	const content = React.createRef<HTMLDivElement>();
	const [
		state,
		setState 
	] = useState(initScrollBarState as ScrollBarState);
	useEffect(()=>{

		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		console.log("ScrollBar - useEffect");
		console.log("ScrollBar - wrapper - height", wrapper.current?.clientHeight);
		console.log("ScrollBar - content - height", content.current?.clientHeight);
		position(wrapper.current?.clientHeight || 0, content.current?.clientHeight || 0);
		setState({...state, scrollY: 0, });

		/**
		 * The function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);

	const position = (wrapperHeight: number, contentHeight: number, ) => {
		let scrollerHeight: number = (wrapperHeight*wrapperHeight)/contentHeight;
		console.log("Scroller - height", scrollerHeight);
		return scrollerHeight;
	};

	const onMouseDown = (e: React.MouseEvent<HTMLDivElement>) => {

	};

	const onMouseOver = (e: React.MouseEvent<HTMLDivElement>) => {};

	return (
		<div className={"ScrollBar"}>
			<div className={"Content"} ref={wrapper}>
				<div ref={content}>{props.children}</div>
			</div>
			<div className={"ScrollContainer"}>
				<div className={"Scroller"} onMouseDown={(e) => 
					onMouseDown(e)} onMouseOver={(e)=>
					onMouseOver(e)}/>
			</div>
		</div>
	);
};

export default ScrollBar;
