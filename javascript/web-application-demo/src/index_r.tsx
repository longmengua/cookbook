import "./index.sass";
import {render} from "react-dom";
import * as React from "react";
import Header from "./Header";
import Dashboard from "./Dashboard";
import Home from "./Home";
import About from "./About";
import PageNotFound from "./PageNotFound";
import {HashRouter, Redirect, Route, Switch, withRouter} from "react-router-dom";
import withRedux from "./withRedux";
import Splash from "./Splash";

export type CustomRouter = {
	path: string,
	name: string,
	display?: boolean,
	component: React.ReactNode
}

export const homePagePath = "#Home";

// todo: @note Routers centralized management
export const routers: Array<CustomRouter> = [
	{path: '/', name: 'Splash', component: <Splash />, display: false},
	{path: '/home', name: 'Home', component: <Home />},
	{path: '/About', name: 'About', component: <About />} ,
	{path: '/Dashboard', name: 'Dashboard', component: <Dashboard />},
	{path: '/PageNotFound', name: 'PageNotFound', component: <PageNotFound />, display: false},
];

// todo: @note
//  "exact = true" means precisely compare path,
//  "exact = false" means display first match, usually using for the mis-mapping path.
const route = () => routers?.map(((o, i)=><Route key={i} path={o.path} exact={true}>{o.component}</Route>));

render(
	<React.StrictMode>
		<Header routers={routers}/>
		<HashRouter>
			<Switch>
				{route()}
				<Redirect to="/PageNotFound" />
			</Switch>
		</HashRouter>
	</React.StrictMode>,
	document.getElementById('root_react')
);
