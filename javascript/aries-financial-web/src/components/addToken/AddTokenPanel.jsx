import React, { Component } from 'react';
import PropTypes from 'prop-types';
import SwitchNetworkNotice from './SwitchNetworkNotice'
import TokenItem from './TokenItem'
import Eth from 'ethjs-query';
import queryString from 'querystringify'
import TOKEN_DATA from '../../setting/add-token';
import "./AddTokenPanel.sass"
import {pathEnum} from "../../App";

const metaMarkAddress = '0x617b3f8050a0bd94b6b1da02b4384ee5b4df13f4';

class AddTokenPanel extends Component {

	constructor (props) {
		const {
			tokenName = 'MetaMarks',
			tokenSymbol = 'MARK',
			tokenDecimals = 18,
			tokenAddress = metaMarkAddress,
			tokenImage = 'https://pbs.twimg.com/profile_images/802481220340908032/M_vde_oi_400x400.jpg',
			tokenNet = '1',
			message = '',
			errorMessage = '',
			net = '1',
			tokenItems = TOKEN_DATA,
		} = props

		super()
		this.state = {
			tokenName,
			tokenSymbol,
			tokenDecimals,
			tokenAddress,
			tokenImage,
			tokenNet,
			message,
			errorMessage,
			net,
			tokenItems
		}

		const search = window.location.search
		const params = queryString.parse(search)

		for (let key in params) {
			this.state[key] = params[key]
		}

		this.updateNet()

	}

	async updateNet () {
		const provider = window.web3.currentProvider
		const eth = new Eth(provider)
		const realNet = await eth.net_version()
		this.setState({ net: realNet })
	}

  addToken = async(tokenAddress, tokenSymbol, tokenDecimals, tokenImage) => {
  	const provider = window.web3.currentProvider
  	provider.sendAsync({
  		method: 'metamask_watchAsset',
  		params: {
  			"type"   : "ERC20",
  			"options": {
  				"address" : tokenAddress,
  				"symbol"  : tokenSymbol,
  				"decimals": tokenDecimals,
  				"image"   : tokenImage,
  			},
  		},
  		id: Math.round(Math.random() * 100000),
  	}, (err, added) => {
  		if (err || 'error' in added) {
  			this.setState({
  				errorMessage: 'There was a problem adding the token.',
  				message     : '',
  			})
  			return
  		}
  		this.setState({
  			message     : 'Token added!',
  			errorMessage: '',
  		})
  	})
  }

  content = (tokenItems, net) => {
	return tokenItems.length ? tokenItems.map(item => <TokenItem key={item.id} item={item} net={net} onAddToken={this.addToken}/>) : <div className="empty-message">Your token list is empty</div>;
  };

  skipBtn = () => {
  	window.location.assign(pathEnum.farming);
  };

  render () {
  	const {
  		tokenNet,
  		net,
  		message,
  		tokenItems,
		errorMessage
  	} = this.state;

  	if (tokenNet !== net) {
  		return <SwitchNetworkNotice net={net} tokenNet={tokenNet}/>
  	}

  	return (
  		<div id={`addTokenPanel`}>
			<h2 className={`alignCenter`}>Click on the token to add to your wallet</h2>
			<h5 className={`alignRight`}>
				<div className={`Button`} onClick={()=>this.skipBtn()}>Next Step >></div>
			</h5>
			<p>{message}{errorMessage}</p>
			<table id={`customers`}>
				<thead>
					<tr>
						<th>Logo</th>
						<th>Symbol</th>
						<th>Decimals</th>
						<th>View</th>
						<th>Add</th>
					</tr>
				</thead>
				<tbody>
					{this.content(tokenItems, net)}
				</tbody>
			</table>
  			<div className="spacer" />
  		</div>
  	)
  }
}

AddTokenPanel.contextTypes = {
	web3: PropTypes.object,
}

export default AddTokenPanel;