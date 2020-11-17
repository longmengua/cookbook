import React, { Component } from 'react';
import PropTypes from 'prop-types';
import SwitchNetworkNotice from './SwitchNetworkNotice'
import TokenItem from './TokenItem'
import Button from '@material-ui/core/Button';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableRow from '@material-ui/core/TableRow';
import TableCell from '@material-ui/core/TableCell';
import Typography from '@material-ui/core/Typography';
import DownloadMetaMaskButton from './DownloadMetaMaskButton';
import Eth from 'ethjs-query';
import etherscanLink from 'etherscan-link';
import { Link } from 'react-router-dom'
//import logo from './coin.jpg';
import queryString from 'querystringify'
import TOKEN_DATA from './token.data';// const SHOP_DATA = [..]

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
		console.log("tokenItems:", tokenItems)
	}

	componentDidMount() {
		// const search = this.props.location.search
		// const params = queryString.parse(search)
		// this.setState(params)
	}

	async updateNet () {
		const provider = window.web3.currentProvider
		const eth = new Eth(provider)
		const realNet = await eth.net_version()
		console.log("realNet:", realNet, typeof realNet)
		this.setState({ net: realNet })
	}

  addToken = async(tokenAddress, tokenSymbol, tokenDecimals, tokenImage) => {
  	console.log('addToken From the App:',tokenAddress, tokenSymbol, tokenDecimals, tokenImage );
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
  		console.log('provider returned', err, added)
  		if (err || 'error' in added) {
  			this.setState({
  				errorMessage: 'There was a problem adding the token.',
  				message     : '',
  			})
  			return
  		}
  		console.log('Token added successfully')
  		this.setState({
  			message     : 'Token added!',
  			errorMessage: '',
  		})
  	})
  }


  render (props, context) {
  	const {
  		//tokenName,
  		tokenSymbol,
  		tokenDecimals,
  		tokenNet,
  		net,
  		tokenImage,
  		tokenAddress,
  		message,
  		errorMessage,
  		tokenItems,
  	} = this.state
  	//console.log("tokenItems:", tokenItems)
  	let error
  	if (errorMessage !== '') {
  		error = <p className="errorMessage">
        There was a problem adding this token to your wallet. Make sure you have the latest version of MetaMask installed!
  			<DownloadMetaMaskButton/>
  		</p>
  	}

  	if (tokenNet !== net) {
  		return <SwitchNetworkNotice net={net} tokenNet={tokenNet}/>
  	}
  	// console.log("tokenItems:", tokenItems)
  	// tokenItems.map(item  =>{
  	//   console.log("mapping:", item.id, item.symbol)
  	//   return true
  	// })

  	return (
  		<div style={{ width: "400px", margin: "0 auto"}}>
  			<header className="App-header">
  				<img src="https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/aave.png" alt="Coin"/>
  				<h1 className="App-title">Click on the token to add to your wallet</h1>
  			</header>

  			<Table>
  				<TableBody>
  					<TableRow>
  						<TableCell>Logo</TableCell>
  						<TableCell>Symbol</TableCell>
  						<TableCell>Decimals</TableCell>
  					</TableRow>
  				</TableBody>
  			</Table>


  			{
  				tokenItems.length ? (
  					tokenItems.map(item => 
  						<TokenItem key={item.id}
  							item={item} net={net} onAddToken={this.addToken}/>)
  				) : (
  					<span className="empty-message">Your token list is empty</span>
  				)
  			}


  			<div>
  				<Button
  					onClick={() => {
  						const { tokenAddress, net } = this.state
  						window.location.href = etherscanLink.createAccountLink(tokenAddress, net)
  					}}
  					href={etherscanLink.createAccountLink(tokenAddress, net)}
  				>View on Etherscan</Button>

  				<Button
  					onClick = {async (event) => {
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
  							console.log('provider returned', err, added)
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
  					}}
  				>Add in Wallet</Button>

  			</div>

  			<p>{message}</p>
  			{error}

  			<div className="spacer"></div>

  			<Typography gutterBottom noWrap>
  				{`
            Create a simple page to watch your token with one click.
          `}
  			</Typography>
  			{/*<Link to="/edit">*/}
  			{/*  <Button>*/}
  			{/*    Create Page*/}
  			{/*  </Button>*/}
  			{/*</Link>*/}

  		</div>
  	)
  }
}

AddTokenPanel.contextTypes = {
	web3: PropTypes.object,
}

export default AddTokenPanel;

/**
            <TableRow>
              <TableCell>Symbol</TableCell>
              <TableCell>{tokenSymbol}</TableCell>
            </TableRow>
            <TableRow>
              <TableCell>Decimals</TableCell>
              <TableCell>{tokenDecimals}</TableCell>
            </TableRow>
 */