import {Status} from "../Enum/Status";

const checkConnection = async (props?: Status) => {
    const p =  (props?: Status) => new Promise(((resolve, reject) => {
        if(!props)reject(false);
        setTimeout(()=>resolve(true),2000);
    }));

    await p(props);


};

export {checkConnection}