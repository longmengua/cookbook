//i18n => {"footer.footer.Text.1":"yearn.finance","footer.footer.Text.2":"Built with","footer.footer.Text.3":"Products","footer.footer.Text.4":"yearn.finance","footer.footer.Text.5":"ygov.finance","footer.footer.Text.6":"yinsure.finance","footer.footer.Text.7":"yborrow.finance","footer.footer.Text.8":"docs.yearn.finance","footer.footer.Text.9":"Community","footer.footer.Text.10":"ycosystem.info","footer.footer.Text.11":"learnyearn.finance","footer.footer.Text.12":"stats.finance","footer.footer.Text.13":"yieldfarming.info","footer.footer.Text.14":"yearn.snapshot.page","footer.footer.Text.15":"vaults.finance","footer.footer.Text.16":"Socials","footer.footer.Text.17":"Twitter","footer.footer.Text.18":"Medium","footer.footer.Text.19":"Discord","footer.footer.Text.20":"Telegram","footer.footer.Text.21":"Github"}
import i18next from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import {
	Typography,
} from '@material-ui/core';
import { colors } from '../../theme';

import AttachMoneyIcon from '@material-ui/icons/AttachMoney';
import HowToVoteIcon from '@material-ui/icons/HowToVote';
import DescriptionIcon from '@material-ui/icons/Description';

import links from "../../setting/links";
import {pathEnum} from "../../App";

const logoImgFooter = require('../../assets/logo/Footer-Logo.png');

const styles = theme => ({
	footer: {
		padding: '24px',
		paddingBottom: '0px',
		display: 'flex',
		justifyContent: 'space-evenly',
		width: '100%',
		background: colors.white,
		borderRadius: '50px 50px 0px 0px',
		border: '1px solid '+colors.borderBlue,
		borderBottom: 'none',
		marginTop: '24px',
		flexWrap: 'wrap',
		boxSizing: 'border-box',
		'@media(max-width:768px)': {
			padding: '18px 10px 0 10px',
		},
	},
	heading: {
		marginBottom: '12px',
		paddingBottom: '9px',
		borderBottom: "3px solid "+colors.borderBlue,
		width: 'fit-content',
		marginLeft: '30px',
		'@media(max-width:768px)': {
			marginLeft: '0px',
		}
	},
	link: {
		paddingBottom: '12px',
		cursor: 'pointer',
		display: 'flex',
		alignItems: 'center',
		'&:hover': {
			textDecoration: 'underline'
		}
	},
	icon: {
		fill: colors.borderBlue,
		marginRight: '6px'
	},
	yearnIcon: {
		minHeight: '100%',
		display: 'flex',
		alignItems: 'center'
	},
	builtWith:{
		display: 'flex',
		flexDirection: 'column',
		alignItems: 'center',
		[theme.breakpoints.down('md')]: {
			display: 'none',
		}
	},
	builtWithLink: {
		paddingTop: '12px'
	},
	builtHeading: {
		marginBottom: '12px',
		paddingBottom: '9px',
		borderBottom: "3px solid "+colors.borderBlue,
		width: 'fit-content',
	},
	products: {
		padding: '0px 24px',
		[theme.breakpoints.down('xs')]: {
			paddingBottom: '24px'
		}
	},
	community: {
		padding: '0px 24px',
		[theme.breakpoints.down('xs')]: {
			paddingBottom: '24px'
		}
	},
	socials: {
		padding: '0px 24px',
	},
	footerWrapper: {
		position: 'relative',
		bottom: '0',
		width: "100%",
	}
});


class Footer extends Component {

	constructor(props) {
		super();

		this.state = {
			modalBuiltWithOpen: false,
		};
	}

	render() {
		const { classes } = this.props;

		return (
			<div className={classes.footerWrapper}>
				<div className={classes.footer}>
					<div className={ classes.builtWith }>
						<Typography className={ classes.builtHeading } variant={ 'h6'} id="footer.footer.Text.1" >{i18next.t('footer.footer.Text.1')}</Typography>
						<img
							alt=""
							src={ logoImgFooter }
							height={ '120px' }
							width={ '120px' }
						/>
					</div>
					<div className={ classes.products }>
						<Typography className={ classes.heading } variant={ 'h6'} id="footer.footer.Text.3" >{i18next.t('footer.footer.Text.3')}</Typography>
						<div  className={ classes.link } onClick={()=> this.props.history.push(pathEnum.introduction)} >
							<DescriptionIcon height='15px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.8" >{i18next.t('footer.footer.Text.22')}</Typography>
						</div>
						<div  className={ classes.link } onClick={()=> this.props.history.push(pathEnum.addToken)} >
							<DescriptionIcon height='15px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.8" >{i18next.t('footer.footer.Text.23')}</Typography>
						</div>
						{/*<div  className={ classes.link } onClick={()=> window.open("https://www.aries.financial/", "_blank")} >*/}
						{/*	<AttachMoneyIcon height='15px' className={ classes.icon } />*/}
						{/*	<Typography variant={ 'h4'}  id="footer.footer.Text.4" >{i18next.t('footer.footer.Text.4')}</Typography>*/}
						{/*</div>*/}
						{/*<div  className={ classes.link } onClick={()=> window.open("https://www.aries.financial/", "_blank")} >*/}
						{/*	<HowToVoteIcon height='15px' className={ classes.icon } />*/}
						{/*	<Typography variant={ 'h4'}  id="footer.footer.Text.5" >{i18next.t('footer.footer.Text.5')}</Typography>*/}
						{/*</div>*/}
						<div  className={ classes.link } onClick={()=> window.open("https://aries-financial.gitbook.io/aries-financial/", "_blank")} >
							<DescriptionIcon height='15px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.8" >{i18next.t('footer.footer.Text.8')}</Typography>
						</div>
					</div>
					<div className={ classes.socials }>
						<Typography className={ classes.heading } variant={ 'h6'} id="footer.footer.Text.16" >{i18next.t('footer.footer.Text.16')}</Typography>
						<div  className={ classes.link } onClick={()=> window.open(links.twitter, "_blank")} >
							<img alt="" src={ require('../../assets/twitter.svg') } height='24px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.17" >{i18next.t('footer.footer.Text.17')}</Typography>
						</div>
						<div  className={ classes.link } onClick={()=> window.open(links.medium, "_blank")} >
							<img alt="" src={ require('../../assets/medium.svg') } height='24px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.18" >{i18next.t('footer.footer.Text.18')}</Typography>
						</div>
						<div  className={ classes.link } onClick={()=> window.open(links.discord, "_blank")} >
							<img alt="" src={ require('../../assets/discord.svg') } height='24px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.19" >{i18next.t('footer.footer.Text.19')}</Typography>
						</div>
						<div  className={ classes.link } onClick={()=> window.open(links.telegram, "_blank")} >
							<img alt="" src={ require('../../assets/telegram.svg') } height='24px' className={ classes.icon } />
							<Typography variant={ 'h4'}  id="footer.footer.Text.20" >{i18next.t('footer.footer.Text.20')}</Typography>
						</div>
					</div>
				</div>
				<div style={{textAlign: "center"}}>Powered by CoinGecko API</div>
			</div>
		);
	}
}

export default withRouter(withStyles(styles)(Footer));
