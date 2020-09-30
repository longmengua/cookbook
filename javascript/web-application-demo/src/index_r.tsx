import {Route, Switch} from "react-router";
import About from "./About";
import Users from "./Users";
import Home from "./Home";
import {render} from "react-dom";
import * as React from "react";

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
