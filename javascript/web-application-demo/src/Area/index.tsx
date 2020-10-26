import "./index.sass";
import "./index_c.css";
import * as React from "react";
import {useEffect, useMemo, useState} from "react";
import {initAreaState, AreaProps, AreaState} from "./interface";
import Arrow from "../Util/Arrow";

const Area: React.FC<AreaProps> = (props: AreaProps) => {
	const {title, children} = useMemo(()=>props, [props]);
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

	const genList = ()=>{
		const _children = children;
		let toReturn: JSX.Element[] = [];
		if(Array.isArray(_children)){
			toReturn = _children.map((node, index)=> <div key={`area-list-${index}`}>
				<label>{`template ${index} => `}</label>
				{node}
			</div>);
		} else if (React.isValidElement(children)) {
			toReturn.push(<>
				<label>{`template 1 => `}</label>
				{_children}
			</>);
		}
		return toReturn;
	};

	return (
		<div className={"Area"}>
			<Arrow />
			<label className={"title"} style={{fontSize: "20px"}}>{title}</label>
			<div className={"list"} style={{marginLeft: "40px"}}>{genList()}</div>
		</div>
	);
};

export default Area;
