import {render, React} from './Common';
import {Route, Switch} from "react-router";
import About from "./About";
import Users from "./Users";
import Home from "./Home";

render(
	<React.StrictMode>
		<Switch>
			<Route path="/about">
				<About />
			</Route>
			<Route path="/users">
				<Users />
			</Route>
			<Route path="/">
				<Home />
			</Route>
		</Switch>
	</React.StrictMode>,
	document.getElementById('root_react')
);
