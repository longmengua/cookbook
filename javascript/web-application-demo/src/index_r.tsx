import "./index.sass";
import {render} from "react-dom";
import * as React from "react";
import Header from "./Header";
import Dashboard from "./Dashboard";
import Home from "./Home";
import About from "./About";
import {HashRouter, Route, Switch} from "react-router-dom";

const routers: Array<{path: string, component: React.ReactNode}> = [
	{path: '/dashboard', component: <Dashboard />},
	{path: '/about', component: <About />} ,
	{path: '/', component: <Home />}
];

const route = () => routers?.map(((o, i)=><Route key={i} path={o.path}>{o.component}</Route>));

render(
	<React.StrictMode>
		<Header />
		<HashRouter>
			<Switch>
				{route()}
			</Switch>
		</HashRouter>
	</React.StrictMode>,
	document.getElementById('root_react')
);
