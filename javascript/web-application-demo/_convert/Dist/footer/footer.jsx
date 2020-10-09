//i18n => {"footer.Text.1":"yearn.finance","footer.Text.2":"Built with","footer.Text.3":"Products","footer.Text.4":"yearn.finance","footer.Text.5":"ygov.finance","footer.Text.6":"yinsure.finance","footer.Text.7":"yborrow.finance","footer.Text.8":"docs.yearn.finance","footer.Text.9":"Community","footer.Text.10":"ycosystem.info","footer.Text.11":"learnyearn.finance","footer.Text.12":"stats.finance","footer.Text.13":"yieldfarming.info","footer.Text.14":"yearn.snapshot.page","footer.Text.15":"vaults.finance","footer.Text.16":"Socials","footer.Text.17":"Twitter","footer.Text.18":"Medium","footer.Text.19":"Discord","footer.Text.20":"Telegram","footer.Text.21":"Github"}
import {i18n as i18next} from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import {
	Typography,
} from '@material-ui/core';
import { colors } from '../../theme';

import AttachMoneyIcon from '@material-ui/icons/AttachMoney';
import HowToVoteIcon from '@material-ui/icons/HowToVote';
import SecurityIcon from '@material-ui/icons/Security';
import DescriptionIcon from '@material-ui/icons/Description';
import MonetizationOnIcon from '@material-ui/icons/MonetizationOn';

import ForumIcon from '@material-ui/icons/Forum';
import BarChartIcon from '@material-ui/icons/BarChart';
import BuildIcon from '@material-ui/icons/Build';

import BuiltWithModal from '../builtwith/builtwithModal.jsx';

const styles = theme => ({
	footer: {
		padding: '24px',
		display: 'flex',
		justifyContent: 'space-evenly',
		width: '100%',
		background: colors.white,
		borderRadius: '50px 50px 0px 0px',
		border: '1px solid '+colors.borderBlue,
		borderBottom: 'none',
		marginTop: '48px',
		flexWrap: 'wrap',
		[theme.breakpoints.down('xs')]: {
			justifyContent: 'flex-start',
		}
	},
	heading: {
		marginBottom: '12px',
		paddingBottom: '9px',
		borderBottom: "3px solid "+colors.borderBlue,
		width: 'fit-content',
		marginLeft: '30px'
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
		padding: '0px 24px'
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
		const { classes, location } = this.props;
		const {
			modalBuiltWithOpen
		} = this.state;

		if(location.pathname === '' || location.pathname === '/') {
			return null;
		}

		return (
			<div className={classes.footer}>
				<div className={ classes.builtWith }>
					<Typography className={ classes.builtHeading } variant={ 'h6'} id="footer.Text.1" >{i18next.t('footer.Text.1')}</Typography>
					<img
						alt=""
						src={ require('../../assets/YFI-logo.png') }
						height={ '120px' }
						width={ '120px' }
					/>
					<div  className={ `${classes.link} ${classes.builtWithLink}` } onClick={ () => { this.builtWithOverlayClicked(); } } >
						<BuildIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.2" >{i18next.t('footer.Text.2')}</Typography>
					</div>
				</div>
				<div className={ classes.products }>
					<Typography className={ classes.heading } variant={ 'h6'} id="footer.Text.3" >{i18next.t('footer.Text.3')}</Typography>
					<div  className={ classes.link } onClick={()=> window.open("https://yearn.finance", "_blank")} >
						<AttachMoneyIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.4" >{i18next.t('footer.Text.4')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://ygov.finance", "_blank")} >
						<HowToVoteIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.5" >{i18next.t('footer.Text.5')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://yinsure.finance", "_blank")} >
						<SecurityIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.6" >{i18next.t('footer.Text.6')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://yborrow.finance", "_blank")} >
						<MonetizationOnIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.7" >{i18next.t('footer.Text.7')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://docs.yearn.finance", "_blank")} >
						<DescriptionIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.8" >{i18next.t('footer.Text.8')}</Typography>
					</div>
				</div>
				<div className={ classes.community }>
					<Typography className={ classes.heading } variant={ 'h6'} id="footer.Text.9" >{i18next.t('footer.Text.9')}</Typography>
					<div  className={ classes.link } onClick={()=> window.open("https://ycosystem.info", "_blank")} >
						<DescriptionIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.10" >{i18next.t('footer.Text.10')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://www.learnyearn.finance", "_blank")}>
						<DescriptionIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.11" >{i18next.t('footer.Text.11')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://stats.finance/yearn", "_blank")} >
						<BarChartIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.12" >{i18next.t('footer.Text.12')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://yieldfarming.info", "_blank")} >
						<BarChartIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.13" >{i18next.t('footer.Text.13')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://feel-the-yearn.app", "_blank")} >
						<BarChartIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'} >feel-the-yearn.app</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://yearn.snapshot.page", "_blank")} >
						<ForumIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.14" >{i18next.t('footer.Text.14')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://vaults.finance", "_blank")} >
						<AttachMoneyIcon height='15px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.15" >{i18next.t('footer.Text.15')}</Typography>
					</div>
				</div>
				<div className={ classes.socials }>
					<Typography className={ classes.heading } variant={ 'h6'} id="footer.Text.16" >{i18next.t('footer.Text.16')}</Typography>
					<div  className={ classes.link } onClick={()=> window.open("https://twitter.com/iearnfinance", "_blank")} >
						<img alt="" src={ require('../../assets/twitter.svg') } height='24px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.17" >{i18next.t('footer.Text.17')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://medium.com/iearn", "_blank")} >
						<img alt="" src={ require('../../assets/medium.svg') } height='24px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.18" >{i18next.t('footer.Text.18')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("http://discord.yearn.finance", "_blank")} >
						<img alt="" src={ require('../../assets/discord.svg') } height='24px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.19" >{i18next.t('footer.Text.19')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://t.me/yearnfinance", "_blank")} >
						<img alt="" src={ require('../../assets/telegram.svg') } height='24px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.20" >{i18next.t('footer.Text.20')}</Typography>
					</div>
					<div  className={ classes.link } onClick={()=> window.open("https://github.com/iearn-finance", "_blank")} >
						<img alt="" src={ require('../../assets/github.svg') } height='24px' className={ classes.icon } />
						<Typography variant={ 'h4'}  id="footer.Text.21" >{i18next.t('footer.Text.21')}</Typography>
					</div>
				</div>
				{ modalBuiltWithOpen && this.renderBuiltWithModal() }
			</div>
		);
	}

  renderBuiltWithModal = () => {
  	return (
  		<BuiltWithModal closeModal={ this.closeBuiltWithModal } modalOpen={ this.state.modalBuiltWithOpen } />
  	);
  }

  builtWithOverlayClicked = () => {
  	this.setState({ modalBuiltWithOpen: true });
  }

  closeBuiltWithModal = () => {
  	this.setState({ modalBuiltWithOpen: false });
  }
}

export default withRouter(withStyles(styles)(Footer));
