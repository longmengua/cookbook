import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useMemo, useState} from "react";
import {initAreaState, AreaProps, AreaState} from "./interface";
import Arrow from "../Util/Arrow";

const Area: React.FC<AreaProps> = (props: AreaProps) => {
	const {title, children} = useMemo(()=>{
		console.log("useMemo");
		return props;
	}, [props]);
	const [state, setState] = useState(initAreaState as AreaState);
	useEffect(()=>{
		/**
		 * ... here is for componentDidMount and componentDidUpdate will trigger this
		 * */
		/**
		 * the function given to return is for componentWillUnmount()
		 * */
		return ()=> {};
	}, []);

	const genList = useMemo(()=>{
		console.log("genList");
		const _children = children;
		let toReturn: JSX.Element[] = [];
		if(Array.isArray(_children)){
			toReturn = _children.map((node, index)=> <div className={"list-area"} key={`template-${index}`}>
				<div className={"list-label"}>{`(style ${index + 1})`}</div>
				{node}
			</div>);
		} else if (React.isValidElement(children)) {
			toReturn.push(<div className={"list-area"}>
				<div>{`(style 1)`}</div>
				{_children}
			</div>);
		}
		return toReturn;
	}, []);

	const triggerExpand = () => {
		console.log("triggerExpand");
		setState({...state, isExpand: !state.isExpand});
	};

	return (
		<div className={"Area"}>
			<div className={"category"} onClick={()=> triggerExpand()}>
				<Arrow rotateDeg={state.isExpand ? 90 : 0}/>
				<label>{title}</label>
			</div>
			<div className={"list"}>{state.isExpand && genList}</div>
		</div>
	);
};

export default Area;
