import i18next from "i18next";
import React, { Component } from "react";
import "./stake.sass"

import {
	CONNECTION_CONNECTED,
	CONNECTION_DISCONNECTED,
} from '../../constants';

import Loader from '../loader';

import Store from "../../stores";
import {GET_STAKE_APY_DETAIL, GET_STAKE_APY_DETAIL_DONE} from "../../constants/constants-extension";
import APYFrame from "../../widgets/APYFrame";
import StakeDetail from "../stake-detail";
const emitter = Store.emitter;
const dispatcher = Store.dispatcher;
const store = Store.store;

class Stake extends Component {

	constructor(props) {
		super(props);

		const account = store.getStore('account');

		this.state = {
			account: account,
			address: account.address ? account.address.substring(0,6)+'...'+account.address.substring(account.address.length-4,account.address.length) : null,
			loading: true,
			isStakeDetail: false,
			pool: null,
		};
		dispatcher.dispatch({ type: GET_STAKE_APY_DETAIL, content: {} });
	}

	componentWillMount() {
		emitter.on(CONNECTION_CONNECTED, this.connectionConnected);
		emitter.on(CONNECTION_DISCONNECTED, this.connectionDisconnected);
		emitter.on(GET_STAKE_APY_DETAIL_DONE, this.getAPYDetail);
	}

	componentWillUnmount() {
		emitter.removeListener(CONNECTION_CONNECTED, this.connectionConnected);
		emitter.removeListener(CONNECTION_DISCONNECTED, this.connectionDisconnected);
		emitter.removeListener(GET_STAKE_APY_DETAIL_DONE, this.getAPYDetail);
	};

	connectionConnected = () => {
		const account = store.getStore('account');
		const that = this;

		this.setState({
			loading: true,
			account: account,
			address: account.address ? account.address.substring(0,6)+'...'+account.address.substring(account.address.length-4,account.address.length) : null
		});

		setTimeout(() => {
			const snackbarObj = { snackbarMessage: i18next.t("Unlock.WalletConnected"), snackbarType: 'Info' }
			that.setState(snackbarObj)
		})
	};

	connectionDisconnected = () => {
		this.setState({
			account: null,
			address: null
		})
	};

	getAPYDetail = () => {
		this.setState({
			loading: false,
		})
	};

	onStake = (pool) => {
		this.setState({isStakeDetail: !this.state.isStakeDetail, pool})
	};

	loopAPYFrame = (stakePools) => {
		return stakePools.map((pool, i) => {
			const token = pool.tokens[0];
			// console.log(token, token.ariesAPY, token.decimals, "tokens ==");
			return <APYFrame key={`APYFrame-${i}`} {...pool} onStake={() => this.onStake(pool)} />;
		})
	};

	render() {
		const { loading, isStakeDetail, pool } = this.state;

		return (
			<div className={`stake`}>
				{ loading && <Loader /> }
				{ !isStakeDetail ?
					<div className={`section`}>{this.loopAPYFrame(store.store.stakePools)}</div> :
					<StakeDetail pool={pool} goBack={() => this.onStake(pool)}/>
				}
			</div>
		);
	};
}

export default Stake;
