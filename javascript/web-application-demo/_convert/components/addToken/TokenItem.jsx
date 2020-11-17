import React from 'react';
import Table from '@material-ui/core/Table';
import Button from '@material-ui/core/Button';
//import Eth from 'ethjs-query';
import etherscanLink from 'etherscan-link';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableRow from '@material-ui/core/TableRow';

//import downloadButton from './download-metamask.png';

const TokenItem = ({item: {imageURL, symbol, decimals, tokenAddress}, net, onAddToken}) => (

	<div>
		<Table>
			<TableBody>
				<TableRow>
					<TableCell>
						<img src={imageURL} className="logo" alt="Coin"/>
					</TableCell>
					<TableCell>{symbol}</TableCell>
					<TableCell>{decimals}</TableCell>
				</TableRow>
			</TableBody>
		</Table>

		<Button
			onClick={() => {
				//const { tokenAddress, net } = this.state
				window.location.href = etherscanLink.createAccountLink(tokenAddress, net)
			}}
			href={etherscanLink.createAccountLink(tokenAddress, net)}
		>View on Etherscan</Button>

		<Button
			onClick = {()=> onAddToken(tokenAddress, symbol, decimals, imageURL)}
		>Add in Wallet</Button>

	</div>
);


export default TokenItem
