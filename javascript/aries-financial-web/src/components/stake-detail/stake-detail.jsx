//i18n => {"stake-detail-Text-1":"This project is in beta. Use at your own risk.","stake-detail-Text-2":"Back","stake-detail-Text-3":"Your Balance","stake-detail-Text-4":"Currently Staked","stake-detail-Text-5":"Rewards Available","stake-detail-Text-6":"yCRV reward requirements","stake-detail-Text-7":"You must have voted in a proposal recently","stake-detail-Text-8":"You must have at least 1000 BPT staked in the Governance pool","stake-detail-Text-9":"Stake Tokens","stake-detail-Text-10":"Claim Rewards","stake-detail-Text-11":"Unstake Tokens","stake-detail-Text-12":"You need to have voted recently in order to claim rewards","stake-detail-Text-13":"You have recently voted, you can unstake at block {gov_voteLock}","stake-detail-Text-14":"Stake your tokens","stake-detail-Text-15":"Back","stake-detail-Text-16":"Stake","stake-detail-Text-17":"Unstake your tokens","stake-detail-Text-18":"Back","stake-detail-Text-19":"Unstake"}
import "./stake-detail.sass"
import i18next from "i18next";
import React, { Component } from "react";
import { withStyles } from '@material-ui/core/styles';
import {
	Typography,
	Button,
	TextField,
	InputAdornment
} from '@material-ui/core';

import CheckIcon from '@material-ui/icons/Check';
import ClearIcon from '@material-ui/icons/Clear';

import Loader from '../loader';
import Snackbar from '../snackbar';

import Store from "../../stores";
import { colors } from '../../theme';

import {
	ERROR,
} from '../../constants';
import {
	EXIT,
	EXIT_RETURNED,
	GET_REWARDS,
	GET_REWARDS_RETURNED, GET_STAKE_APY_DETAIL, GET_STAKE_APY_DETAIL_DONE,
	STAKE,
	STAKE_RETURNED,
	WITHDRAW,
	WITHDRAW_RETURNED
} from "../../constants/constants-extension";
import {withRouter} from "react-router-dom";
import Timer from "../../widgets/Timer";

const styles = theme => ({
	intro: {
		width: '100%',
		position: 'relative',
		display: 'flex',
		justifyContent: 'space-between',
		alignItems: 'center',
	},
	introCenter: {
		minWidth: '100%',
		textAlign: 'center',
		padding: '48px 0px'
	},
	investedContainer: {
		display: 'flex',
		flex: 1,
		flexDirection: 'column',
		alignItems: 'center',
		justifyContent: 'center',
		padding: '12px',
		minWidth: '100%',
		[theme.breakpoints.up('md')]: {
			minWidth: '800px',
		}
	},
	connectContainer: {
		padding: '12px',
		display: 'flex',
		justifyContent: 'center',
		width: '100%',
		maxWidth: '450px',
		[theme.breakpoints.up('md')]: {
			width: '450',
		}
	},
	disaclaimer: {
		padding: '12px',
		border: '1px solid rgb(174, 174, 174)',
		borderRadius: '0.75rem',
		marginBottom: '24px',
		background: colors.white,
	},
	overview: {
		// display: 'flex',
		// flexWrap: 'wrap',
		// justifyContent: 'space-around',
		// alignItems: 'center',
		padding: '28px 30px',
		borderRadius: '50px',
		border: '1px solid '+colors.borderBlue,
		marginTop: '40px',
		background: colors.white,
	},
	overviewField: {
		margin: '10px',
		display: 'flex',
		alignItems: 'center',
		// justifyContent: 'space-evenly',
		'@media(max-width:768px)': {
			flexDirection: 'column',
		},
	},
	overviewTitle: {
		color: colors.darkGray,
		width: '300px',
		textAlign: 'left',
		// flex: 1,
		'@media(max-width:768px)': {
			textAlign: 'center',
		},
	},
	overviewValue: {
		// flex: 1,
	},
	actions: {
		width: '100%',
		display: 'flex',
		justifyContent: 'space-between',
		alignItems: 'center',
		maxWidth: '900px',
		flexWrap: 'wrap',
		background: colors.white,
		border: '1px solid '+colors.borderBlue,
		padding: '28px 30px',
		borderRadius: '50px',
		marginTop: '40px'
	},
	actionContainer: {
		minWidth: 'calc(50% - 40px)',
		display: 'flex',
		alignItems: 'center',
		justifyContent: 'center',
		margin: '20px',
		'@media(max-width:800px)': {
			width: '100%'
		}
	},
	primaryButton: {
		'&:hover': {
			backgroundColor: "#2F80ED",
		},
		padding: '20px 32px',
		backgroundColor: "#2F80ED",
		borderRadius: '50px',
		fontWeight: 500,
	},
	actionButton: {
		padding: '20px 32px',
		borderRadius: '50px',
	},
	buttonText: {
		fontWeight: '700',
	},
	stakeButtonText: {
		fontWeight: '700',
		color: 'white',
	},
	valContainer: {
		display: 'flex',
		flexDirection: 'column',
		width: '100%'
	},
	actionInput: {
		padding: '0px 0px 12px 0px',
		fontSize: '0.5rem'
	},
	inputAdornment: {
		fontWeight: '600',
		fontSize: '1.5rem'
	},
	assetIcon: {
		display: 'inline-block',
		verticalAlign: 'middle',
		borderRadius: '25px',
		background: '#dedede',
		height: '30px',
		width: '30px',
		textAlign: 'center',
		marginRight: '16px'
	},
	balances: {
		width: '100%',
		textAlign: 'right',
		paddingRight: '20px',
		cursor: 'pointer'
	},
	stakeTitle: {
		width: '100%',
		color: colors.darkGray,
		marginBottom: '20px'
	},
	stakeButtons: {
		width: '100%',
		display: 'flex',
		justifyContent: 'space-between',
		align: 'center',
		marginTop: '20px',
	},
	stakeButton: {
		minWidth: '300px',
		'@media(max-width:800px)': {
			width: '100%'
		}
	},
	requirement: {
		display: 'flex',
		alignItems: 'center'
	},
	check: {
		paddingTop: '6px'
	},
	voteLockMessage: {
		margin: '20px'
	},
	title: {
		width: '100%',
		color: colors.darkGray,
		minWidth: '100%',
		marginLeft: '20px'
	},
});

const emitter = Store.emitter;
const dispatcher = Store.dispatcher;
const store = Store.store;

class StakeDetail extends Component {

	constructor(props) {
		super(props);
		const account = store.getStore('account');
		const pool = props.pool;

		this.state = {
			pool: pool,
			loading: !(account || pool),
			account: account,
			value: 'options',
			voteLockValid: false,
			balanceValid: false,
			voteLock: null,
		};
	}

	componentWillMount() {
		emitter.on(ERROR, this.errorReturned);
		emitter.on(STAKE_RETURNED, this.showHash);
		emitter.on(WITHDRAW_RETURNED, this.showHash);
		emitter.on(EXIT_RETURNED, this.showHash);
		emitter.on(GET_REWARDS_RETURNED, this.showHash);
		emitter.on(GET_STAKE_APY_DETAIL_DONE, this.reRenderPage);
	}

	componentWillUnmount() {
		emitter.removeListener(ERROR, this.errorReturned);
		emitter.removeListener(STAKE_RETURNED, this.showHash);
		emitter.removeListener(WITHDRAW_RETURNED, this.showHash);
		emitter.removeListener(EXIT_RETURNED, this.showHash);
		emitter.removeListener(GET_REWARDS_RETURNED, this.showHash);
		emitter.removeListener(GET_STAKE_APY_DETAIL_DONE, this.reRenderPage);
	};

	reRenderPage = () => {
		this.setState({ loading: false });
	};

	showHash  = (txHash) => {
		this.setState({ snackbarMessage: null, snackbarType: null, loading: false });
		const that = this;
		setTimeout(() => {
			const snackbarObj = { snackbarMessage: txHash, snackbarType: 'Hash' };
			that.setState(snackbarObj);
		});
	};

	errorReturned = (error) => {
		const snackbarObj = { snackbarMessage: null, snackbarType: null };
		this.setState(snackbarObj);
		this.setState({ loading: false });
		const that = this;
		setTimeout(() => {
			const snackbarObj = { snackbarMessage: error.toString(), snackbarType: 'Error' };
			that.setState(snackbarObj);
		});
	};

	render() {
		const { classes, goBack } = this.props;
		const {
			value,
			pool,
			loading,
			snackbarMessage,
			voteLockValid,
			balanceValid,
		} = this.state;
		// console.log(pool, "Render - each pool ==");
		return (
			<div className={`stake-detail`}>
				<div className={ classes.intro }>
					<Button
						className = { classes.stakeButton }
						variant = "outlined"
						color = "secondary"
						disabled = { loading }
						onClick = { goBack }
					>
						<Typography variant={ 'h4'} id="stake-detail-Text-2" >{i18next.t('stake-detail-Text-2')}</Typography>
					</Button>
					<Button
						className = { classes.stakeButton }
						variant = "outlined"
						color = "secondary"
						disabled = { loading }
						onClick = { ()=>{
							dispatcher.dispatch({ type: GET_STAKE_APY_DETAIL, content: {} });
							this.setState({ loading: true });
						} }
					>
						<Typography variant={ 'h4'} id="stake-detail-Text-20" >{i18next.t('stake-detail-Text-20')}</Typography>
					</Button>
				</div>
				<div className={ classes.overview }>
					<div className={ classes.overviewField }>
						<Typography variant={ 'h3' } className={ classes.overviewTitle } id="stake-detail-Text-3" >{i18next.t('stake-detail-Text-3')}</Typography>
						<Typography variant={ 'h2' } className={ classes.overviewValue }>
							{ pool.tokens[0].balance }
							<img
								alt=""
								src={ require('../../assets/stake-detail/'+ pool.tokens[0].symbol) }
								height="30px"
								style={{marginLeft: "10px"}}
							/>
						</Typography>
					</div>
					<div className={ classes.overviewField }>
						<Typography variant={ 'h3' } className={ classes.overviewTitle } id="stake-detail-Text-4" >{i18next.t('stake-detail-Text-4')}</Typography>
						<Typography variant={ 'h2' } className={ classes.overviewValue }>
							{ pool.tokens[0].stakedBalance }
							<img
								alt=""
								src={ require('../../assets/stake-detail/'+ pool.tokens[0].symbol) }
								height="30px"
								style={{marginLeft: "10px"}}
							/>
						</Typography>
					</div>
					<div className={ classes.overviewField }>
						<Typography variant={ 'h3' } className={ classes.overviewTitle } id="stake-detail-Text-5" >{i18next.t('stake-detail-Text-5')}</Typography>
						<Typography variant={ 'h2' } className={ classes.overviewValue }>
							{ pool.tokens[0].rewardsAvailable }
							<img
								alt=""
								src={ require('../../assets/stake-detail/'+ pool.tokens[0].rewardsSymbol) }
								height="30px"
								style={{marginLeft: "10px"}}
							/>
						</Typography>
					</div>
				</div>
				{ ['FeeRewards'].includes(pool.id) &&
				<div className={ classes.actions }>
					<Typography className={ classes.stakeTitle } variant={ 'h3'} id="stake-detail-Text-6" >{i18next.t('stake-detail-Text-6')}</Typography>
					<div className={ classes.requirement }>
						<Typography variant={'h4'} id="stake-detail-Text-7" >{i18next.t('stake-detail-Text-7')}</Typography><Typography variant={'h4'} className={ classes.check }>{ voteLockValid ? <CheckIcon style={{ color: colors.green }} /> : <ClearIcon style={{ color: colors.red }} /> }</Typography>
					</div>
					<div className={ classes.requirement }>
						<Typography variant={'h4'} id="stake-detail-Text-8" >{i18next.t('stake-detail-Text-8')}</Typography><Typography variant={'h4'} className={ classes.check }>{ balanceValid ? <CheckIcon style={{ color: colors.green }} /> : <ClearIcon style={{ color: colors.red }} /> }</Typography>
					</div>
				</div>
				}
				{ value === 'options' && this.renderOptions() }
				{ value === 'stake' && this.renderStake() }
				{ value === 'claim' && this.renderClaim() }
				{ value === 'unstake' && this.renderUnstake() }
				{ value === 'exit' && this.renderExit() }

				{ snackbarMessage && this.renderSnackbar() }
				{ loading && <Loader /> }
			</div>
		);
	}

	renderOptions = () => {
		const { classes } = this.props;
		const {
			loading,
			pool,
			voteLockValid,
			balanceValid,
			voteLock,
			gov_breakerEnabled,
			gov_voteLockValid,
			gov_voteLock,
		} = this.state;

		return (
			<div className={`render-options`}>
				<Typography variant={ 'h3'} className={ classes.title } noWrap>{ pool.name }</Typography>
				<div className={ classes.actionContainer}>
					<Button
						fullWidth
						className={ loading ? classes.actionButton : classes.primaryButton }
						variant="outlined"
						color={loading ? "primary" : ""}
						disabled={ !pool.depositsEnabled || (['FeeRewards'].includes(pool.name) ?  (loading || !voteLockValid || !balanceValid) : loading) }
						onClick={ () => this.setState({ value: "stake" }) }
					>
						<Typography className={ loading ? classes.buttonText : classes.stakeButtonText} variant={ 'h4'} id="stake-detail-Text-9" >
							{i18next.t('stake-detail-Text-9')}
						</Typography>
					</Button>
				</div>
				<div className={ classes.actionContainer}>
					<Timer buttonText={classes.buttonText} actionButton={classes.actionButton} onClick={this.onClaim} text={i18next.t('stake-detail-Text-10')} disabled={ loading || (['GovernanceV2'].includes(pool.name) && !gov_voteLockValid && !gov_breakerEnabled) }/>
				</div>
				<div className={ classes.actionContainer}>
					<Button
						fullWidth
						className={ classes.actionButton }
						variant="outlined"
						color="primary"
						disabled={ loading  || (['GovernanceV2'].includes(pool.name) && gov_voteLockValid) || (pool.name === 'Governance' && (voteLockValid )) }
						onClick={ () => { this.navigateInternal('unstake'); } }
					>
						<Typography className={ classes.buttonText } variant={ 'h4'} id="stake-detail-Text-11" >{i18next.t('stake-detail-Text-11')}</Typography>
					</Button>
				</div>
				{/*<div className={ classes.actionContainer}>*/}
				{/*	{ !['GovernanceV2'].includes(pool.name) &&*/}
				{/*	<Button*/}
				{/*		fullWidth*/}
				{/*		className={ classes.actionButton }*/}
				{/*		variant="outlined"*/}
				{/*		color="primary"*/}
				{/*		disabled={ (pool.name === 'Governance' ? (loading || voteLockValid ) : loading  ) }*/}
				{/*		onClick={ () => { this.onExit(); } }*/}
				{/*	>*/}
				{/*		<Typography className={ classes.buttonText } variant={ 'h4'}>Exit: Claim and Unstake</Typography>*/}
				{/*	</Button>*/}
				{/*	}*/}
				{/*</div>*/}
				{/*{ (['Governance', 'GovernanceV2'].includes(pool.name) && voteLockValid) && <Typography variant={'h4'} className={ classes.voteLockMessage }>Unstaking tokens only allowed once all your pending votes have closed at Block: {voteLock}</Typography> }*/}
				{/*{ (['GovernanceV2'].includes(pool.name) && !gov_voteLockValid  && !gov_breakerEnabled) && <Typography variant={'h4'} className={ classes.voteLockMessage } id="stake-detail-Text-12" >{i18next.t('stake-detail-Text-12')}</Typography> }*/}
				{/*{ (['GovernanceV2'].includes(pool.name) && gov_voteLockValid) && <Typography variant={'h4'} className={ classes.voteLockMessage } id="stake-detail-Text-13" >{i18next.t('stake-detail-Text-13')} {gov_voteLock}</Typography> }*/}
			</div>
		);
	}

	navigateInternal = (val) => {
		this.setState({ value: val });
	}

	renderStake = () => {
		const { classes } = this.props;
		const { loading, pool } = this.state;

		const asset = pool.tokens[0];

		return (
			<div className={ classes.actions }>
				<Typography className={ classes.stakeTitle } variant={ 'h3'} id="stake-detail-Text-14" >{i18next.t('stake-detail-Text-14')}</Typography>
				{ this.renderAssetInput(asset, 'stake') }
				<div className={ classes.stakeButtons }>
					<Button
						className={ classes.stakeButton }
						variant="outlined"
						color="secondary"
						disabled={ loading }
						onClick={ () => { this.navigateInternal('options'); } }
					>
						<Typography variant={ 'h4'} id="stake-detail-Text-15" >{i18next.t('stake-detail-Text-15')}</Typography>
					</Button>
					<Button
						className={ classes.stakeButton }
						variant="outlined"
						color="secondary"
						disabled={ loading }
						onClick={ () => { this.onStake(); } }
					>
						<Typography variant={ 'h4'} id="stake-detail-Text-16" >{i18next.t('stake-detail-Text-16')}</Typography>
					</Button>
				</div>

			</div>
		);
	}

	renderUnstake = () => {
		const { classes } = this.props;
		const { loading, pool, voteLockValid } = this.state;

		const asset = pool.tokens[0];

		return (
			<div className={ classes.actions }>
				<Typography className={ classes.stakeTitle } variant={ 'h3'} id="stake-detail-Text-17" >{i18next.t('stake-detail-Text-17')}</Typography>
				{ this.renderAssetInput(asset, 'unstake') }
				<div className={ classes.stakeButtons }>
					<Button
						className={ classes.stakeButton }
						variant="outlined"
						color="secondary"
						disabled={ loading }
						onClick={ () => { this.navigateInternal('options'); } }
					>
						<Typography variant={ 'h4'} id="stake-detail-Text-18" >{i18next.t('stake-detail-Text-18')}</Typography>
					</Button>
					<Button
						className={ classes.stakeButton }
						variant="outlined"
						color="secondary"
						disabled={ (pool.name === 'Governance' ? (loading || voteLockValid ) : loading  ) }
						onClick={ () => { this.onUnstake(); } }
					>
						<Typography variant={ 'h4'} id="stake-detail-Text-19" >{i18next.t('stake-detail-Text-19')}</Typography>
					</Button>
				</div>

			</div>
		);
	};

	closeModal = () => {
		this.setState({ modalOpen: false });
	};

	onStake = () => {
		// console.log(this.state, "onStake ==");
		this.setState({ amountError: false });
		const { pool } = this.state;
		const tokens = pool.tokens;
		const selectedToken = tokens[0];
		const amount = this.state[selectedToken.id + '_stake'];

		this.setState({ loading: true });
		dispatcher.dispatch({ type: STAKE, content: { asset: selectedToken, amount: amount } });
	};

	onClaim = () => {
		// console.log(this.state, "onClaim ==");
		const { pool } = this.state;
		this.setState({ loading: true });
		dispatcher.dispatch({ type: GET_REWARDS, content: pool});
	};

	onUnstake = () => {
		// console.log(this.state, "onUnstake ==");
		this.setState({ amountError: false });
		const { pool } = this.state;
		const tokens = pool.tokens;
		const selectedToken = tokens[0];
		const amount = this.state[selectedToken.id + '_unstake'];

		this.setState({ loading: true });
		dispatcher.dispatch({ type: WITHDRAW, content: { asset: selectedToken, amount: amount } });
	};

	onExit = () => {
		// console.log(this.state, "onExit ==");
		const { pool } = this.state;
		this.setState({ loading: true });
		dispatcher.dispatch({ type: EXIT, content: pool});
	};

	renderAssetInput = (asset, type) => {
		const {
			classes
		} = this.props;

		const {
			loading
		} = this.state;

		const amount = this.state[asset.id + '_' + type];
		const amountError = this.state[asset.id + '_' + type + '_error'];

		return (
			<div className={ classes.valContainer } key={asset.id + '_' + type}>
				<div className={ classes.balances }>
					{ type === 'stake' &&
					<Typography variant='h4' onClick={ () => { this.setAmount(asset.id, type, (asset ? asset.balance.toString().substr(0, asset.balance.length - 1) : 0)); } } className={ classes.value } noWrap>
						{ 'Balance: '+ ( asset && asset.balance ? asset.balance : '0.0000') }
						<img
							alt=""
							src={ require('../../assets/stake-detail/'+asset.symbol) }
							height="30px"
						/>
					</Typography> }
					{ type === 'unstake' && <Typography variant='h4' onClick={ () => { this.setAmount(asset.id, type, (asset ? asset.stakedBalance : 0)); } } className={ classes.value } noWrap>{ 'Balance: '+ ( asset && asset.stakedBalance ? asset.stakedBalance : '0.0000') } { asset ? asset.symbol : '' }</Typography> }
				</div>
				<div>
					<TextField
						fullWidth
						disabled={ loading }
						className={ classes.actionInput }
						id={ '' + asset.id + '_' + type }
						value={ amount }
						error={ amountError }
						onChange={ this.onChange }
						placeholder="0.00"
						variant="outlined"
						InputProps={{
							endAdornment: <InputAdornment position="end" className={ classes.inputAdornment }><Typography variant='h3' className={ '' }>{ asset.depositToken }</Typography></InputAdornment>,
							startAdornment: <InputAdornment position="end" className={ classes.inputAdornment }>
								<div className={ classes.assetIcon }>
									<img
										alt=""
										src={ require('../../assets/stake-detail/'+asset.symbol) }
										height="30px"
									/>
								</div>
							</InputAdornment>,
						}}
					/>
				</div>
			</div>
		);
	}

	renderSnackbar = () => {
		const {
			snackbarType,
			snackbarMessage
		} = this.state;
		return <Snackbar type={ snackbarType } message={ snackbarMessage } open={true}/>;
	};

	onChange = (event) => {
		let val = [];
		val[event.target.id] = event.target.value;
		// console.log(val, "==");
		this.setState(val);
	};

	setAmount = (id, type, balance) => {
		const bal = balance === '' ? '0' : balance;
		let val = [];
		val[id + '_' + type] = bal;
		this.setState(val);
	}

}

export default withRouter(withStyles(styles)(StakeDetail));
// todo: 0.000000000000000008