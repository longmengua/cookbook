import "./index.sass";
import {render} from "react-dom";
import * as React from "react";
import {
	BrowserRouter as Router,
	Switch,
	Route,
	Link
} from "react-router-dom";
import About from "./About";
import Users from "./Users";
import Home from "./Home";
import Header from "./Header";
import Dashboard from "./Dashboard";

render(
	<React.StrictMode>
		<Router>
			<Header />
			<div className={"section"}>
				<Switch>
					<Route path="/dashboard">
						<Dashboard />
					</Route>
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
			</div>
		</Router>
	</React.StrictMode>,
	document.getElementById('root_react')
);
