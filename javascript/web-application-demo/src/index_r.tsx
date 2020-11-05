import "./index.sass";
import {render} from "react-dom";
import * as React from "react";
import {
	BrowserRouter as Router,
	Switch,
	Route,
} from "react-router-dom";
import About from "./About";
import Home from "./Home";
import Header from "./Header";
import Dashboard from "./Dashboard";
import WithRouter from "./WithRouter";

render(
	<React.StrictMode>
		<WithRouter>
			<WithRouter.Path path={`/`} component={()=> <div><Header /><Home/></div>} />
			<WithRouter.Path path={`/about`} component={()=> <div><Header /><About/></div>} />
			<WithRouter.Path path={`/dashboard`} component={()=> <div><Header /><Dashboard/></div>} />
		</WithRouter>
		{/*<Router>*/}
		{/*	<Switch>*/}
		{/*		<Route path="/dashboard">*/}
		{/*			<Dashboard />*/}
		{/*		</Route>*/}
		{/*		<Route path="/about">*/}
		{/*			<About />*/}
		{/*		</Route>*/}
		{/*		<Route path="/">*/}
		{/*			<Home />*/}
		{/*		</Route>*/}
		{/*	</Switch>*/}
		{/*</Router>*/}
	</React.StrictMode>,
	document.getElementById('root_react')
);
