import i18next from "i18next";
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { withStyles } from '@material-ui/core/styles';
import {
	Typography,
	Card,
} from '@material-ui/core';
import { colors } from '../../theme';

import {
	CONNECTION_CONNECTED,
	CONNECTION_DISCONNECTED,
	GET_VAULT_BALANCES_FULL,
	VAULT_BALANCES_FULL_RETURNED,
} from '../../constants';

import Loader from '../loader';

import Store from "../../stores";
const emitter = Store.emitter;
const dispatcher = Store.dispatcher;
const store = Store.store;

const styles = theme => ({

});

class Stake extends Component {

	constructor() {
		super();

		const account = store.getStore('account');

		this.state = {
			assets: store.getStore('vaultAssets'),
			loading: true
		};

		if(account && account.address) {
			dispatcher.dispatch({ type: GET_VAULT_BALANCES_FULL, content: { } });
		}
	}

	componentWillMount() {
		emitter.on(VAULT_BALANCES_FULL_RETURNED, this.statisticsReturned);
		emitter.on(CONNECTION_CONNECTED, this.connectionConnected);
		emitter.on(CONNECTION_DISCONNECTED, this.connectionDisconnected);
	}

	componentWillUnmount() {
		emitter.removeListener(VAULT_BALANCES_FULL_RETURNED, this.statisticsReturned);
		emitter.removeListener(CONNECTION_CONNECTED, this.connectionConnected);
		emitter.removeListener(CONNECTION_DISCONNECTED, this.connectionDisconnected);
	};

	render() {
		const { classes } = this.props;
		const { loading } = this.state;

		return (
			<div className={ classes.root }>
				<Card className={ classes.pairs }>
					<table className={ classes.tableContainer }>
						<thead>
							{ this.renderHeaders() }
						</thead>
						<tbody>
							{ this.renderStats() }
						</tbody>
					</table>
				</Card>
				{ loading && <Loader /> }
			</div>
		);
	};
}

export default withRouter(withStyles(styles)(Stake));
