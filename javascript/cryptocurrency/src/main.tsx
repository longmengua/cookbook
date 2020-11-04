import "./main.sass";
import {render} from "react-dom";
import * as React from "react";
import {
	BrowserRouter as Router,
	Switch,
	Route,
	Link
} from "react-router-dom";
import Dashboard from "../../web-application-demo/src/Dashboard";
import About from "../../web-application-demo/src/About";
import Home from "../../web-application-demo/src/Home";

render(
	<React.StrictMode>
		<Router>
			<Switch>
				<Route path="/dashboard">
					<div>3</div>
				</Route>
				<Route path="/about">
					<div>2</div>
				</Route>
				<Route path="/">
					<div>1</div>
				</Route>
			</Switch>
		</Router>
	</React.StrictMode>,
	document.getElementById('root_react')
);
