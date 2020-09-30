import App from './App';
import {render, React} from './Common';
import {Route, Switch} from "react-router";

render(
	<React.StrictMode>
		<Switch>
			<Route path="/about">
				<App />
				{/*<About />*/}
			</Route>
			<Route path="/users">
				{/*<Users />*/}
			</Route>
			<Route path="/">
				{/*<Home />*/}
			</Route>
		</Switch>
	</React.StrictMode>,
	document.getElementById('root_react')
);
