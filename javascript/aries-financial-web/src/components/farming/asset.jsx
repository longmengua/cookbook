//i18n => {"vault-asset-Text-1":"Strategy:","vault-asset-Text-2":"Currently Active:","vault-asset-Text-3":"Yearly Growth:","vault-asset-Text-4":"Monthly Growth:","vault-asset-Text-5":"Weekly Growth:","vault-asset-Text-6":"Statistics:","vault-asset-Text-7":"Total Earnings:","vault-asset-Text-8":"Deposits:","vault-asset-Text-9":"Withdrawals:","vault-asset-Text-10":"Transferred In:","vault-asset-Text-11":"Transferred Out:","vault-asset-Text-12":"Deposit","vault-asset-Text-13":"Deposit All","vault-asset-Text-14":"Deposits are currently disabled for this vault","vault-asset-Text-15":"Withdraw","vault-asset-Text-16":"Withdraw All"}
import i18next from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import {
	Typography,
	TextField,
	Button
} from '@material-ui/core';

import {
	ERROR,
	DEPOSIT_VAULT,
	DEPOSIT_VAULT_RETURNED,
	WITHDRAW_VAULT,
	WITHDRAW_VAULT_RETURNED,
	DEPOSIT_ALL_VAULT,
	DEPOSIT_ALL_VAULT_RETURNED,
	WITHDRAW_ALL_VAULT,
	WITHDRAW_ALL_VAULT_RETURNED
} from '../../constants'

import { colors } from '../../theme'

import Store from "../../stores";
import {Decimal} from "decimal.js";
import {formatMoney} from "../../util/Format";
const emitter = Store.emitter
const dispatcher = Store.dispatcher
const store = Store.store

const styles = theme =>
	({
		value: {
			cursor: 'pointer'
		},
		actionInput: {
			padding : '0px 0px 12px 0px',
			fontSize: '0.5rem'
		},
		balances: {
			width       : '100%',
			textAlign   : 'right',
			paddingRight: '20px',
			cursor      : 'pointer'
		},
		vaultContainer: {
			display      : 'flex',
			flexDirection: 'column',
			width        : '100%'
		},
		actionsContainer: {
			paddingBottom                 : '12px',
			display                       : 'flex',
			flex                          : '1',
			padding                       : '24px',
			[theme.breakpoints.down('sm')]: {
				flexDirection: 'column'
			}
		},
		title: {
			paddingRight: '24px'
		},
		actionButton: {
			height: '47px'
		},
		tradeContainer: {
			flex         : 1,
			display      : 'flex',
			flexDirection: 'column',
			alignItems   : 'center'
		},
		sepperator: {
			borderBottom                : '1px solid #E1E1E1',
			margin                      : '24px',
			[theme.breakpoints.up('sm')]: {
				width       : '40px',
				borderBottom: 'none',
				margin      : '0px'
			}
		},
		scaleContainer: {
			display       : 'flex',
			justifyContent: 'space-between',
			padding       : '0px 0px 12px 0px',
			alignItems    : 'center',
			flexWrap      : 'wrap',
		},
		scale: {
			minWidth: '10px'
		},
		buttonText: {
			fontWeight: '700',
		},
		headingContainer: {
			width                       : '100%',
			display                     : 'flex',
			[theme.breakpoints.up('sm')]: {
				display: 'none',
			}
		},
		heading: {
			paddingBottom               : '12px',
			flex                        : 1,
			flexShrink                  : 0,
			[theme.breakpoints.up('sm')]: {
				display: 'none',
			}
		},
		right: {
			textAlign: 'right'
		},
		buttons: {
			display: 'flex',
			width  : '100%'
		},
		disabledContainer: {
			width     : '100%',
			paddingTop: '12px',
			textAlign : 'center'
		},
		assetSummary: {
			display     : 'flex',
			alignItems  : 'center',
			flex        : 1,
			padding     : '12px 24px',
			background  : 'rgba(146,178,245, 0.2)',
			// width       : '100%',
			marginBottom: '24px',
			flexWrap    : 'wrap'
		},
		headingEarning: {
			flex   : 1,
			padding: '12px',
		},
		headingStrategy: {
			padding: '12px',
			width  : '256px'
		},
		grey: {
			color: colors.darkGray
		},
		flexy: {
			display       : 'flex',
			alignItems    : 'center',
			justifyContent: 'flex-start'
		},
		fullWidth: {
			minWidth    : '100%',
			margin      : '18px 0px',
			borderBottom: '1px solid '+colors.borderBlue
		},
		assetSummarySectionheader: {
			width: '83px'
		}
	});


class Asset extends Component {

	constructor() {
		super()

		this.state = {
			amount           : '',
			amountError      : false,
			redeemAmount     : '',
			redeemAmountError: false,
			account          : store.getStore('account'),
		}
	}

	componentWillMount() {
		emitter.on(DEPOSIT_VAULT_RETURNED, this.depositReturned);
		emitter.on(WITHDRAW_VAULT_RETURNED, this.withdrawReturned);
		emitter.on(DEPOSIT_ALL_VAULT_RETURNED, this.depositReturned);
		emitter.on(WITHDRAW_ALL_VAULT_RETURNED, this.withdrawReturned);
		emitter.on(ERROR, this.errorReturned);
	}

	componentWillUnmount() {
		emitter.removeListener(DEPOSIT_VAULT_RETURNED, this.depositReturned);
		emitter.removeListener(WITHDRAW_VAULT_RETURNED, this.withdrawReturned);
		emitter.removeListener(DEPOSIT_ALL_VAULT_RETURNED, this.depositReturned);
		emitter.removeListener(WITHDRAW_ALL_VAULT_RETURNED, this.withdrawReturned);
		emitter.removeListener(ERROR, this.errorReturned);
	};

	depositReturned = () => {
		this.setState({ loading: false, amount: '' })
	};

	withdrawReturned = (txHash) => {
		this.setState({ loading: false, redeemAmount: '' })
	};

	errorReturned = (error) => {
		this.setState({ loading: false })
	};

	calculationForWithdrawBalance = (digital, vaultBalance, stakedBalance, pricePerFullShare) => {
		return (Math.floor((vaultBalance + stakedBalance) * pricePerFullShare*10**digital)/10**digital).toFixed(digital);
	};

	calculation = (yearlyGrowth, ariesGrowth) => {
		// console.log(yearlyGrowth, "calculation - yearlyGrowth ==");
		// console.log(ariesGrowth, "calculation - ariesGrowth ==");
		return (yearlyGrowth + ariesGrowth).toFixed(2);
	};

	_getAriesAPY = (asset) => {
		return asset.ariesAPY || '0.00';
	};

	render() {
		const { classes, asset } = this.props;
		const {
			amount,
			amountError,
			redeemAmount,
			redeemAmountError,
			loading
		} = this.state

		return (
			<div className={ classes.vaultContainer }>
				<div className={ classes.assetSummary }>
					<div className={ classes.assetSummarySectionheader }>
						<Typography variant={ 'h4' } color="primary" noWrap id="vault-asset-Text-1" >{i18next.t('vault-asset-Text-1')}</Typography>
					</div>
					<div className={classes.headingStrategy}>
						<div>
							<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-2" >{i18next.t('vault-asset-Text-2')}</Typography>
							{/*<Typography variant={ 'h4' } noWrap>{ asset.strategyName }</Typography>*/}
							<div>{`${formatMoney(asset.liquidityLock)}`}</div>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-3" >{i18next.t('vault-asset-Text-3')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{this.calculation(this._getAPY(asset)/1, this._getAriesAPY(asset)/1)} %</Typography>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-4" >{i18next.t('vault-asset-Text-4')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{this.calculation(this._getAPY(asset)/12, this._getAriesAPY(asset)/12)} %</Typography>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-5" >{i18next.t('vault-asset-Text-5')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{this.calculation(this._getAPY(asset)/52, this._getAriesAPY(asset)/52)} %</Typography>
						</div>
					</div>
					<div className={ classes.fullWidth } />
					<div className={ classes.assetSummarySectionheader }>
						<Typography variant={ 'h4' } color="primary" noWrap id="vault-asset-Text-6" >{i18next.t('vault-asset-Text-6')}</Typography>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-7" >{i18next.t('vault-asset-Text-7')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{ asset.addressStatistics ? (asset.addressStatistics.earnings/10**asset.decimals).toFixed(2) : '0.00' } {asset.symbol}</Typography>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-8" >{i18next.t('vault-asset-Text-8')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{ asset.addressStatistics ? (asset.addressStatistics.totalDeposits/10**asset.decimals).toFixed(2) : '0.00' } {asset.symbol}</Typography>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-9" >{i18next.t('vault-asset-Text-9')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{ asset.addressStatistics ? (asset.addressStatistics.totalWithdrawals/10**asset.decimals).toFixed(2) : '0.00' } {asset.symbol}</Typography>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-10" >{i18next.t('vault-asset-Text-10')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{ asset.addressStatistics ? (asset.addressStatistics.totalTransferredIn/10**asset.decimals).toFixed(2) : '0.00' } {asset.symbol}</Typography>
						</div>
					</div>
					<div className={classes.headingEarning}>
						<Typography variant={ 'h5' } className={ classes.grey } id="vault-asset-Text-11" >{i18next.t('vault-asset-Text-11')}</Typography>
						<div className={ classes.flexy }>
							<Typography variant={ 'h4' } noWrap>{ asset.addressStatistics ? (asset.addressStatistics.totalTransferredOut/10**asset.decimals).toFixed(2) : '0.00' } {asset.symbol}</Typography>
						</div>
					</div>
				</div>
				<div className={ classes.actionsContainer }>
					<div className={ classes.tradeContainer }>
						<div className={ classes.balances }>
							<Typography id={`vault-asset-Text-17`} variant="h4" onClick={ () => { this.setAmount(100) } } className={ classes.value } noWrap>{ i18next.t('vault-asset-Text-17')+ (asset.balance ? (Math.floor(asset.balance*10000)/10000).toFixed(4) : '0.0000') } { asset.tokenSymbol ? asset.tokenSymbol : asset.symbol }</Typography>
						</div>
						<TextField
							fullWidth
							className={ classes.actionInput }
							id="amount"
							value={ amount }
							error={ amountError }
							onChange={ this.onChange }
							disabled={ loading }
							placeholder="0.00"
							variant="outlined"
							onKeyDown={ this.inputKeyDown }
						/>
						<div className={ classes.scaleContainer }>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setAmount(25) } }>
								<Typography variant={'h5'}>25%</Typography>
							</Button>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setAmount(50) } }>
								<Typography variant={'h5'}>50%</Typography>
							</Button>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setAmount(75) } }>
								<Typography variant={'h5'}>75%</Typography>
							</Button>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setAmount(100) } }>
								<Typography variant={'h5'}>100%</Typography>
							</Button>
						</div>
						<div className={ classes.buttons }>
							{ asset.deposit === true &&
							<Button
								className={ classes.actionButton }
								variant="outlined"
								color="primary"
								disabled={ loading }
								onClick={ this.onDeposit }
								fullWidth
							>
								<Typography className={ classes.buttonText } variant={ 'h5'} color={asset.disabled?'':'secondary'} id="vault-asset-Text-12" >{i18next.t('vault-asset-Text-12')}</Typography>
							</Button>
							}
							{ asset.depositAll === true &&
							<Button
								className={ classes.actionButton }
								variant="outlined"
								color="primary"
								disabled={ loading }
								onClick={ this.onDepositAll }
								fullWidth
							>
								<Typography className={ classes.buttonText } variant={ 'h5'} color={asset.disabled?'':'secondary'} id="vault-asset-Text-13" >{i18next.t('vault-asset-Text-13')}</Typography>
							</Button>
							}
						</div>
						{ asset.depositDisabled === true &&
						<div className={classes.disabledContainer}>
							<Typography variant="h4" id="vault-asset-Text-14" >{i18next.t('vault-asset-Text-14')}</Typography>
						</div>
						}
					</div>
					<div className={ classes.sepperator }></div>
					<div className={classes.tradeContainer}>
						<div className={ classes.balances }>
							<Typography variant="h4" onClick={ () => { this.setRedeemAmount(100) } }  className={ classes.value } noWrap>
								{/*Here is the balance displaying area*/}
								{ this.calculationForWithdrawBalance(4, asset.vaultBalance, asset.stakedBalance, asset.pricePerFullShare) }
								{ asset.symbol }
								/
								{ this.calculationForWithdrawBalance(4, asset.vaultBalance, asset.stakedBalance, 1) }
								{ asset.vaultSymbol }
							</Typography>
						</div>
						<TextField
							fullWidth
							className={ classes.actionInput }
							id="redeemAmount"
							value={ redeemAmount }
							error={ redeemAmountError }
							onChange={ this.onChange }
							disabled={ loading }
							placeholder="0.00"
							variant="outlined"
							onKeyDown={ this.inputRedeemKeyDown }
						/>
						<div className={ classes.scaleContainer }>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setRedeemAmount(25) } }>
								<Typography variant={'h5'}>25%</Typography>
							</Button>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setRedeemAmount(50) } }>
								<Typography variant={'h5'}>50%</Typography>
							</Button>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setRedeemAmount(75) } }>
								<Typography variant={'h5'}>75%</Typography>
							</Button>
							<Button
								className={ classes.scale }
								variant="text"
								disabled={ loading }
								color="primary"
								onClick={ () => { this.setRedeemAmount(100) } }>
								<Typography variant={'h5'}>100%</Typography>
							</Button>
						</div>
						<div className={ classes.buttons }>
							{ asset.withdraw === true &&
							<Button
								className={ classes.actionButton }
								variant="outlined"
								color="primary"
								disabled={ loading }
								onClick={ this.onWithdraw }
								fullWidth
							>
								<Typography className={ classes.buttonText } variant={ 'h5'} color="secondary" id="vault-asset-Text-15" >{i18next.t('vault-asset-Text-15')}</Typography>
							</Button>
							}
							{ asset.withdrawAll === true &&
							<Button
								className={ classes.actionButton }
								variant="outlined"
								color="primary"
								disabled={ loading }
								onClick={ this.onWithdrawAll }
								fullWidth
							>
								<Typography className={ classes.buttonText } variant={ 'h5'} color="secondary" id="vault-asset-Text-16" >{i18next.t('vault-asset-Text-16')}</Typography>
							</Button>
							}
						</div>
					</div>
				</div>
			</div>
		)
	};

	_getAPY = (asset) => {
		const { basedOn } = this.props
		const initialApy = '0.00'

		if(asset && asset.stats) {
			switch (basedOn) {
				case 1:
					return asset.stats.apyOneWeekSample || initialApy
				case 2:
					return asset.stats.apyOneMonthSample || initialApy
				case 3:
					return asset.stats.apyInceptionSample || initialApy
				default:
					return asset.apy
			}
		} else if (asset.apy) {
			return asset.apy
		} else {
			return initialApy
		}
	}

	onChange = (event) => {
		let val = []
		val[event.target.id] = event.target.value;
		this.setState(val)
	}

	inputKeyDown = (event) => {
		if (event.which === 13) {
			this.onInvest();
		}
	}

	onDeposit = () => {
		this.setState({ amountError: false })

		const { amount } = this.state
		const { asset, startLoading } = this.props

		if (!amount || isNaN(amount) || amount <= 0 || amount > asset.balance) {
			this.setState({ amountError: true })
			return false
		}

		this.setState({ loading: true })
		startLoading();
		// console.log(this.props.asset, "check asset ==");
		dispatcher.dispatch({ type: DEPOSIT_VAULT, content: { amount: amount, asset: asset } })
	}

	onDepositAll = () => {
		const { asset, startLoading } = this.props

		this.setState({ loading: true })
		startLoading();
		// console.log(this.props.asset, "check asset ==");
		dispatcher.dispatch({ type: DEPOSIT_ALL_VAULT, content: { asset: asset } })
	}

	onWithdraw = () => {
		this.setState({ redeemAmountError: false })

		const { asset, startLoading  } = this.props;
		const redeemAmount = new Decimal(this.state.redeemAmount).dividedBy(new Decimal(asset.pricePerFullShare).toFixed()).toFixed();
		const vaultBalance = new Decimal(asset.vaultBalance).toFixed();

		if (redeemAmount <= 0 || redeemAmount > vaultBalance) {
			this.setState({ redeemAmountError: true })
			return false
		}

		this.setState({ loading: true })
		startLoading();
		// console.log(this.props.asset, "check asset ==");
		dispatcher.dispatch({ type: WITHDRAW_VAULT, content: { amount: redeemAmount, asset: asset } })
	}

	onWithdrawAll = () => {
		const { asset, startLoading } = this.props

		this.setState({ loading: true });
		startLoading();
		// console.log(this.props.asset, "check asset ==");
		dispatcher.dispatch({ type: WITHDRAW_ALL_VAULT, content: { asset: asset } })
	}

	setAmount = (percent) => {
		if (this.state.loading) {
			return
		}
		const balance = new Decimal(this.props.asset.balance);
		this.setState({ amount: balance.times(percent/100).toFixed() })
	}

	setRedeemAmount = (percent) => {
		if (this.state.loading) {
			return
		}
		const vaultBalance = new Decimal(this.props.asset.vaultBalance);
		const pricePerFullShare = new Decimal(this.props.asset.pricePerFullShare);
		this.setState({ redeemAmount: vaultBalance.times(percent/100).times(pricePerFullShare).toFixed() })
	}
}

export default withRouter(withStyles(styles, { withTheme: true })(Asset));
