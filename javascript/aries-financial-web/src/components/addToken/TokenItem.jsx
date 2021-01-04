import React from 'react';
import etherscanLink from 'etherscan-link';
import "./AddTokenPanel.sass"

const TokenItem = ({item: {imageURL, symbol, decimals, tokenAddress}, net, onAddToken, classes}) => (
	<tr>
		<td>
			<img src={imageURL} className={`logo`} alt="Coin"/>
		</td>
		<td>{symbol}</td>
		<td>{decimals}</td>
		<td>
			<div className={`Button`}
				 onClick={() => {
					 window.location.href = etherscanLink.createAccountLink(tokenAddress, net)
				 }}
				 href={etherscanLink.createAccountLink(tokenAddress, net)}
			>View on Etherscan</div>
		</td>
		<td>
			<div className={`Button`}
				 onClick = {()=> onAddToken(tokenAddress, symbol, decimals, imageURL)}
			>Add in Wallet</div>
		</td>
	</tr>
);


export default TokenItem
