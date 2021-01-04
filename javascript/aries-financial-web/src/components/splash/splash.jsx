//i18n => {}
import i18next from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import { } from '@material-ui/core';
import {pathEnum} from "../../App";


const styles = theme => ({
	root: {
		backgroundImage: 'url('+require('../../assets/logo/Header-Logo.png')+')',
		height: '100vh',
		backgroundPosition: 'center',
		backgroundRepeat: 'no-repeat',
		backgroundSize: 'auto',
	},
});

class Splash extends Component {
	constructor() {
		super();

		this.state = {

		};
		setTimeout(()=> {
			//loads a new document
			window.location.assign(pathEnum.introduction);
		}, 500);
	}

	render() {
		const { classes } = this.props;

		return (
			<div className={ classes.root }/>
		);
	};
}

export default withRouter(withStyles(styles)(Splash));
