import React, {useState} from 'react';
import logo from '../logo.svg';
import './App.css';

const App:React.FC = (prop: any) => {
  let test = 234;
  const [state, setState] = useState(Object(""));

  const onClick = () => {
      console.log("==");
    test = 432;
    setState(Object(""));
  };

  return (
    <div className="App">
      <img src={logo} className="App-logo" alt="logo" />
      <div>value: {test}{state}</div>
      <div onClick={onClick} style={{border: "1px solid black", cursor: "pointer"}}>setState</div>
    </div>
  );
};

export default App;
