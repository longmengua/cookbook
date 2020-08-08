import React from 'react';
import {render} from 'react-dom'
import * as image from './asset/index'

const home = () => {
    let toReturn = <div>image</div>
    if(image != null)toReturn = <div style={{backgroundImage: image.fall}}/>
    return <div>{toReturn}</div>
}

render(home(), document.getElementById("root"));