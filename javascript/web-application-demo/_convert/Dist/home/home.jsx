//i18n => {"home.home.Text.1":"Dashboard","home.home.Text.2":"{ \"Get a quick glance at how your portfolio is growing while invested in yearn's products.\" }","home.home.Text.3":"{ t(\"Home.Vaults\") }","home.home.Text.4":"{ \"Vaults follow unique strategies that are designed to maximize the yield of the deposited asset and minimize risk.\" }","home.home.Text.5":"{ t(\"Home.Earn\") }","home.home.Text.6":"{ \"Earn performs profit switching for lending providers, moving your funds between dydx, Aave, Compound autonomously.\" }","home.home.Text.7":"{ t(\"Home.Zap\") }","home.home.Text.8":"{ \"Zaps help you save on gas fees. Zap directly into or out of Curve pools from the base assets.\" }","home.home.Text.9":"{ t(\"Home.Cover\") }","home.home.Text.10":"{ \"Get cover with Nexus Mutual from yinsure.finance\" }","home.home.Text.11":"Stats","home.home.Text.12":"{ \"Get a quick glance at how yearn's vaults are performing.\" }"}
import i18next from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import {
	Card,
	Typography,
} from '@material-ui/core';
import { withNamespaces } from 'react-i18next';
import { colors } from '../../theme';
import FlashOnIcon from '@material-ui/icons/FlashOn';
import AttachMoneyIcon from '@material-ui/icons/AttachMoney';
import BarChartIcon from '@material-ui/icons/BarChart';
import PieChartIcon from '@material-ui/icons/PieChart';
import SecurityIcon from '@material-ui/icons/Security';

const styles = theme => ({
	root: {
		flex: 1,
		display: 'flex',
		width: '100%',
		justifyContent: 'space-around',
		alignItems: 'center',
		flexDirection: 'column',
		[theme.breakpoints.up('sm')]: {
			flexDirection: 'row',
		}
	},
	card: {
		flex: '1',
		height: '25vh',
		width: '100%',
		display: 'flex',
		justifyContent: 'center',
		alignItems: 'center',
		flexDirection: 'column',
		cursor: 'pointer',
		borderRadius: '0px',
		transition: 'background-color 0.2s linear',
		[theme.breakpoints.up('sm')]: {
			height: '100vh',
			minHeight: '50vh',
		}
	},
	earn: {
		backgroundColor: colors.white,
		'&:hover': {
			backgroundColor: colors.pink,
			'& .title': {
				color: colors.white
			},
			'& .icon': {
				color: colors.white
			},
			'& .description': {
				display: 'block',
				color: colors.white,
				padding: '48px',
				textAlign: 'center'
			}
		},
		'& .title': {
			color: colors.pink
		},
		'& .icon': {
			color: colors.pink
		},
		'& .description': {
			display: 'none'
		}
	},
	zap: {
		backgroundColor: colors.white,
		'&:hover': {
			backgroundColor: colors.blue,
			'& .title': {
				color: colors.white,
			},
			'& .icon': {
				color: colors.white
			},
			'& .description': {
				display: 'block',
				color: colors.white,
				padding: '48px',
				textAlign: 'center'
			}
		},
		'& .title': {
			color: colors.blue,
			display: 'block'
		},
		'& .soon': {
			color: colors.blue,
			display: 'none'
		},
		'& .icon': {
			color: colors.blue
		},
		'& .description': {
			display: 'none'
		}
	},
	apr: {
		backgroundColor: colors.white,
		'&:hover': {
			backgroundColor: colors.lightBlack,
			'& .title': {
				color: colors.white
			},
			'& .icon': {
				color: colors.white
			},
			'& .description': {
				display: 'block',
				color: colors.white,
				padding: '48px',
				textAlign: 'center'
			}
		},
		'& .title': {
			color: colors.lightBlack
		},
		'& .icon': {
			color: colors.lightBlack
		},
		'& .description': {
			display: 'none'
		}
	},
	vault: {
		backgroundColor: colors.white,
		'&:hover': {
			backgroundColor: colors.tomato,
			'& .title': {
				color: colors.white,
			},
			'& .icon': {
				color: colors.white
			},
			'& .description': {
				display: 'block',
				color: colors.white,
				padding: '48px',
				textAlign: 'center'
			}
		},
		'& .title': {
			color: colors.tomato,
		},
		'& .icon': {
			color: colors.tomato
		},
		'& .description': {
			display: 'none'
		}
	},
	cover: {
		backgroundColor: colors.white,
		'&:hover': {
			backgroundColor: colors.compoundGreen,
			'& .title': {
				color: colors.white,
			},
			'& .icon': {
				color: colors.white
			},
			'& .description': {
				display: 'block',
				color: colors.white,
				padding: '48px',
				textAlign: 'center'
			}
		},
		'& .title': {
			color: colors.compoundGreen,
		},
		'& .icon': {
			color: colors.compoundGreen
		},
		'& .description': {
			display: 'none'
		}
	},
	title: {
		padding: '24px',
		paddingBottom: '0px',
		[theme.breakpoints.up('sm')]: {
			paddingBottom: '24px'
		}
	},
	icon: {
		fontSize: '60px',
		[theme.breakpoints.up('sm')]: {
			fontSize: '100px',
		}
	},
	link: {
		textDecoration: 'none'
	}
});

class Home extends Component {

	constructor(props) {
		super();

		this.state = {
		};
	}

	render() {
		const { classes, t, location } = this.props;

		return (
			<div className={ classes.root }>
				<Card className={ `${classes.card} ${classes.apr}` } onClick={ () => { this.nav(location.pathname+'dashboard'); } }>
					<BarChartIcon className={ `${classes.icon} icon` } />
					<Typography variant={'h3'} className={ `${classes.title} title` } id="home.home.Text.1" >{i18next.t('home.home.Text.1')}</Typography>
					<Typography variant={'h4'} className={ `${classes.description} description` } id="home.home.Text.2" >{i18next.t('home.home.Text.2')}</Typography>
				</Card>
				<Card className={ `${classes.card} ${classes.vault}` } onClick={ () => { this.nav(location.pathname+'vaults'); }}>
					<PieChartIcon className={ `${classes.icon} icon` } />
					<Typography variant={'h3'} className={ `${classes.title} title` } id="home.home.Text.3" >{i18next.t('home.home.Text.3')}</Typography>
					<Typography variant={'h4'} className={ `${classes.description} description` } id="home.home.Text.4" >{i18next.t('home.home.Text.4')}</Typography>
				</Card>
				<Card className={ `${classes.card} ${classes.earn}` } onClick={ () => { this.nav(location.pathname+'earn'); } }>
					<AttachMoneyIcon className={ `${classes.icon} icon` } />
					<Typography variant={'h3'} className={ `${classes.title} title` } id="home.home.Text.5" >{i18next.t('home.home.Text.5')}</Typography>
					<Typography variant={'h4'} className={ `${classes.description} description` } id="home.home.Text.6" >{i18next.t('home.home.Text.6')}</Typography>
				</Card>
				<Card className={ `${classes.card} ${classes.zap}` } onClick={ () => { this.nav(location.pathname+'zap'); } }>
					<FlashOnIcon className={ `${classes.icon} icon` } />
					<Typography variant={'h3'} className={ `${classes.title} title` } id="home.home.Text.7" >{i18next.t('home.home.Text.7')}</Typography>
					<Typography variant={'h4'} className={ `${classes.description} description` } id="home.home.Text.8" >{i18next.t('home.home.Text.8')}</Typography>
				</Card>
				<Card className={ `${classes.card} ${classes.cover}` } onClick={ () => { window.open("https://yinsure.finance", "_blank"); } }>
					<SecurityIcon className={ `${classes.icon} icon` } />
					<Typography variant={'h3'} className={ `${classes.title} title` } id="home.home.Text.9" >{i18next.t('home.home.Text.9')}</Typography>
					<Typography variant={'h4'} className={ `${classes.description} description` } id="home.home.Text.10" >{i18next.t('home.home.Text.10')}</Typography>
				</Card>
				<Card className={ `${classes.card} ${classes.apr}` } onClick={ () => { this.nav(location.pathname+'stats'); } }>
					<BarChartIcon className={ `${classes.icon} icon` } />
					<Typography variant={'h3'} className={ `${classes.title} title` } id="home.home.Text.11" >{i18next.t('home.home.Text.11')}</Typography>
					<Typography variant={'h4'} className={ `${classes.description} description` } id="home.home.Text.12" >{i18next.t('home.home.Text.12')}</Typography>
				</Card>
			</div>
		);
	};

  nav = (screen) => {
  	this.props.history.push(screen);
  }
}

export default withNamespaces()(withRouter(withStyles(styles)(Home)));
