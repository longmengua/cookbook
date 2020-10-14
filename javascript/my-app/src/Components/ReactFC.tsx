import React, {useEffect, useState} from "react";
import {Status} from "../Enum/Status";
import ReactFCProps from "../Interfaces/ReactFCProps";
import {checkConnection} from "../Service/Connect";

const ReactFC: React.FC<ReactFCProps> = (props: ReactFCProps) => {
    const [state, setState] = useState(Status.offline);

    useEffect(()=>{

    }, []);

    return <div></div>
};

export default ReactFC;
