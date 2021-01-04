//i18n => {"header.header.Text.1":"yearn.finance","header.header.Text.2":"\n                Connect your wallet\n              "}
import i18next from "i18next";
import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import {
	Typography
} from '@material-ui/core';
import { withRouter } from "react-router-dom";
import PropTypes from 'prop-types';
import { colors } from '../../theme';
import ENS from 'ethjs-ens';

import {
	CONNECTION_CONNECTED,
	CONNECTION_DISCONNECTED,
} from '../../constants';

import UnlockModal from '../unlock/unlockModal.jsx';

import Store from "../../stores";
import {i18nKeys, changI18nLanguage, setLocalStorage} from "../../i18n";
import {getI18n} from "react-i18next";
import {pathEnum} from "../../App";
const emitter = Store.emitter;
const store = Store.store;

const logoImgHeader = require('../../assets/logo/Header-Logo.png');

const styles = theme => ({
	languages: {
		margin: "0 20px",
		'@media(max-width:768px)': {
			width: '100%',
			textAlign: 'center',
			margin: '10px 0'
		}
	},
	root: {
		verticalAlign: 'top',
		width: '100%',
		display: 'flex',
		marginBottom: '24px',
		boxSizing: "border-box",
	},
	headerV2: {
		background: colors.white,
		border: '1px solid '+colors.borderBlue,
		borderTop: 'none',
		width: '100%',
		borderRadius: '0px 0px 50px 50px',
		display: 'flex',
		padding: '24px 32px',
		alignItems: 'center',
		justifyContent: 'center',
		boxSizing: "border-box",
		[theme.breakpoints.down('sm')]: {
			justifyContent: 'space-between',
			padding: '16px 24px'
		},
		'@media(max-width:768px)': {
			display: 'block',
		}
	},
	icon: {
		alignItems: 'center',
		cursor: 'pointer',
		display: "flex",
		'@media(max-width:768px)': {
			display: 'block',
		},
	},
	imageContainer: {
		'@media(max-width:768px)': {
			width: '100%',
			textAlign: 'center',
		},
	},
	linksContainer: {
		flex: 1,
		'@media(max-width:768px)': {
			marginBottom: '10px'
		}
	},
	links: {
		justifyContent: "space-evenly",
		display: "flex",
		// justifyContent: 'center',
		'@media(max-width:768px)': {
			display: "block",
			width: '100%',
			textAlign: 'center',
			margin: '0px'
		}
	},
	link: {
		whiteSpace: "nowrap",
		margin: "0px 10px",
		paddingBottom: "5px",
		textAlign: "center",
		cursor: 'pointer',
		'&:hover': {
			borderBottom: "3px solid "+colors.borderBlue,
		},
		'@media(max-width:768px)': {
			margin: "10px",
		}
	},
	title: {
		textTransform: 'capitalize'
	},
	linkActive: {
		borderBottom: "3px solid "+colors.borderBlue,
	},
	account: {
		width: '373px',
	},
	walletAddress: {
		margin: '0 auto',
		width: 'fit-content',
		justifyContent: 'center',
		padding: '12px',
		border: '2px solid rgb(174, 174, 174)',
		borderRadius: '50px',
		display: 'flex',
		alignItems: 'center',
		cursor: 'pointer',
		'&:hover': {
			border: "2px solid "+colors.borderBlue,
			background: 'rgba(47, 128, 237, 0.1)',
		},
		[theme.breakpoints.down('sm')]: {
			marginTop: "10px",
			border: "1px solid "+colors.borderBlue,
			background: colors.white,
		}
	},
	walletTitle: {
		flex: 1,
		color: colors.darkGray
	},
	connectedDot: {
		background: colors.compoundGreen,
		opacity: '1',
		borderRadius: '10px',
		width: '10px',
		height: '10px',
		marginRight: '3px',
		marginLeft:'6px'
	},
	name: {
		paddingLeft: '24px',
		[theme.breakpoints.down('sm')]: {
			display: 'none',
		}
	}
});

class Header extends Component {

	constructor(props) {
		super(props);

		this.state = {
			account: store.getStore('account'),
			modalOpen: false
		};
	}

	componentWillMount() {
		emitter.on(CONNECTION_CONNECTED, this.connectionConnected);
		emitter.on(CONNECTION_DISCONNECTED, this.connectionDisconnected);
	}

	componentWillUnmount() {
		emitter.removeListener(CONNECTION_CONNECTED, this.connectionConnected);
		emitter.removeListener(CONNECTION_DISCONNECTED, this.connectionDisconnected);
	}

  connectionConnected = () => {
  	this.setState({ account: store.getStore('account') });
  	this.setAddressEnsName();
  };

  connectionDisconnected = () => {
  	this.setState({ account: store.getStore('account') });
  }

  setAddressEnsName = async () => {
  	const context = store.getStore('web3context');
  	if(context && context.library && context.library.provider) {
  		const provider = context.library.provider;
  		const account = store.getStore('account');
  		const { address } = account;
  		const network = provider.networkVersion;
  		const ens = new ENS({ provider, network });
  		const addressEnsName = await ens.reverse(address).catch(() => {});
  		if (addressEnsName) {
  			this.setState({ addressEnsName });
  		}
  	}
  };

  changI18nLanguage = (i18nKey) => {
  	this.props.updateUIFunc && this.props.updateUIFunc();
  	changI18nLanguage(i18nKey);
  	setLocalStorage("lang", i18nKey);
  };

  render() {
  	const {
  		classes
  	} = this.props;

  	const {
  		account,
  		addressEnsName,
  		modalOpen
  	} = this.state;

  	var address = null;
  	if (account.address) {
  		address = account.address.substring(0,6)+'...'+account.address.substring(account.address.length-4,account.address.length);
  	}
  	const addressAlias = addressEnsName || address;

  	return (
  		<div style={{textAlign: "center", marginBottom: "25px"}}>
			<div className={ classes.root }>
				<div className={ classes.headerV2 }>
					<div className={ classes.icon }>
						<div className={ classes.imageContainer}>
							<img
								alt=""
								src={ logoImgHeader }
								height={ '40px' }
								onClick={ () => { this.nav(''); } }
							/>
						</div>
						<div className={classes.languages}>
							{Object.keys(i18nKeys).map(currentLang=>
								<img key={currentLang}
									 style={{
										width:"35px",
										height:"30px",
										cursor: "pointer",
									 	margin: "0 5px",
									 	border: getI18n().language === currentLang ? "1px solid rgb(245,204,91)" : "1px solid rgb(174,174,174,0.4)",
									 	boxShadow: getI18n().language === currentLang ? "3px 3px 2px rgb(245,204,91)" : ""
									 }}
									 src={ require(`../../assets/nationalFlag/${currentLang}.jpg`) }
									 onClick={ () => this.changI18nLanguage(currentLang) }
							/>)}
						</div>
					</div>
					<div className={ classes.linksContainer }>
						<div className={ classes.links }>
							{/*{ this.renderLink("header.header.Text.10", pathEnum.video, i18next.t('header.header.Text.10')) }*/}
							{ this.renderLink("header.header.Text.4", pathEnum.farming, i18next.t('header.header.Text.4')) }
							{ this.renderLink("header.header.Text.9", pathEnum.stake, i18next.t('header.header.Text.9')) }
							{/*{ this.renderLink("header.header.Text.11", pathEnum.addToken, i18next.t('header.header.Text.11')) }*/}
							{ this.renderLink("header.header.Text.12", pathEnum.buyToken, i18next.t('header.header.Text.12')) }
						</div>
					</div>
					<div className={ classes.account }>
						{ address &&
						<Typography variant={ 'h4'} className={ classes.walletAddress } noWrap onClick={this.addressClicked} >
							{ addressAlias }
							<div className={ classes.connectedDot } />
						</Typography>
						}
						{ !address &&
						<Typography variant={ 'h4'} className={ classes.walletAddress } noWrap onClick={this.addressClicked}  id="header.header.Text.2" >
							{i18next.t('header.header.Text.2')}
						</Typography>
						}
					</div>
				</div>
				{ modalOpen && this.renderModal() }
			</div>
			<div style={{
				textAlign: "center",
				display: "inline-block",
				padding: "10px",
				border: "1px solid",
				color: "rgba(25, 101, 233, 0.5)",
				borderRadius: "5px",
				fontFamily: "monospace",
				fontSize: "15px",
			}}>
				{i18next.t('header.header.Text.13')}
			</div>
		</div>
  	);
  }

  renderLink = (id, path, desc) => {
  	const {
  		classes
  	} = this.props;

  	return (
  		<div id={id} className={ `${classes.link} ${(window.location.pathname === path) && classes.linkActive}` } onClick={ () => { this.nav(path); } }>
  			<Typography variant={'h3'} className={ `title` }>{ desc }</Typography>
  		</div>
  	);
  }

  nav = (path) => {
  	if(path === pathEnum.buyToken){
		window.open("https://app.uniswap.org/#/swap?inputCurrency=0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48&outputCurrency=0x68e8a20128e1902c02f533a02ed0cfd8396e3fbc", "_blank", null);
	} else {
  		this.props.history.push(path);
	}
  };

  addressClicked = () => {
  	this.setState({ modalOpen: true });
  }

  closeModal = () => {
  	this.setState({ modalOpen: false });
  }

  renderModal = () => {
  	return (
  		<UnlockModal closeModal={ this.closeModal } modalOpen={ this.state.modalOpen } />
  	);
  }
}

Header.propTypes = {
	updateUIFunc: PropTypes.func,
	classes: PropTypes.any,
	history: PropTypes.shape({
		push: PropTypes.func.isRequired
	}),
};

export default withRouter(withStyles(styles)(Header));
