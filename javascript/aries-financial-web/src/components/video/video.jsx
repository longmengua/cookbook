//i18n => {}
import i18next from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import {pathEnum} from "../../App";
import "./video.sass"
import { Player } from 'video-react';


const styles = theme => ({
	root: {
		// height: '100vh',
		// minHeight: '800px',
		// position: 'relative',
	},
	content: {
		// top: '45%',
		// position: 'relative',
		// transform: 'translateY(-50%)',
		textAlign: 'center',
		width: '70%',
		margin: '0 auto',
	},
	video: {
		width: '100%',
	},
	button: {
		cursor: "pointer",
		fontSize: "18px",
	},
	skip: {
		textAlign: 'center',
		cursor: "pointer",
	}
});

class Video extends Component {
	ref = React.createRef();

	constructor() {
		super();

		this.state = {

		};
	}

	play = () => {
		this.ref.paused ? this.ref.play() : this.ref.pause();
	};

	skip = () => {
		window.location.assign(pathEnum.addToken);
	};

	render() {
		const { classes } = this.props;

		return (
			<div className={`${classes.root} video`}>
				<div className={ classes.content }>
					<h1 className={`alignCenter`} id="video-video-Text-1" >{i18next.t("video-video-Text-1")}</h1>
					<h5 className={`alignCenter`}>
						<div className={`Button`} onClick={this.skip} id="video-video-Text-2" >{i18next.t("video-video-Text-2")} >> </div>
					</h5>
					<Player
						ref={this.ref}
						playsInline
						poster={require('../../assets/logo/Header-Logo.png')}
						// src={require('../../assets/video/introduction.mp4')}
						src="https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/aries_intro.mp4"
					/>
				</div>
			</div>
		);
	};
}

export default withRouter(withStyles(styles)(Video));
