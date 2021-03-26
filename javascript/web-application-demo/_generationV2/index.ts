const fs = require('fs');
const path = require('path');
const jsonTemplate = (id, poolId, name, type, farmName, feedAddr, tokenAddr, strategyAddr, vTokenAddr) => {
	return {
		id: id,
		order: 0,
		poolId: poolId,
		name: name,
		type: type,
		farmName: farmName,

		tokenBalance: "''",
		vaultBalance: "''",
		rewardBalance: "''",

		farmAPY: "''",
		ariesAPY: "''",
		farmAPR: "''",
		ariesAPR: "''",
		multiplier: "''",

		controlledFeeNote: "''",
		platformFeeNote: "''",
		maxEntranceFee: "''",
		withdrawalFee: "''",
		notes: "''",

		tokenPrice: "''",
		vaultTL: "''",
		vaultPrice: "''",
		vaultShare: "''",
		vaultAllocPoint: "''",
		vaultTotalAllocPoint: "''",
		feedAddr: feedAddr,

		tokenDecimal: 18,
		tokenAddr: tokenAddr,
		tokenContractLink: "''",

		vTokenDecimal: 28,
		vTokenAddr: vTokenAddr,
		vTokenContractLink: "''",

		strategyDecimal: 18,
		strategyAddr: strategyAddr,
		strategyContractLink: "''",

		tokenABI: "[{'constant':false,'inputs':[{'name':'_spender','type':'address'},{'name':'_value','type':'uint256'}],'name':'approve','outputs':[{'name':'success','type':'bool'}],'payable':false,'stateMutability':'nonpayable','type':'function'},{'constant':false,'inputs':[{'name':'_spender','type':'address'},{'name':'_value','type':'uint256'}],'name':'approve','outputs':[{'name':'success','type':'bool'}],'payable':false,'stateMutability':'nonpayable','type':'function'},{'constant':false,'inputs':[{'name':'_to','type':'address'},{'name':'_value','type':'uint256'}],'name':'showMeTheMoney','outputs':[],'payable':false,'stateMutability':'nonpayable','type':'function'},{'constant':false,'inputs':[{'name':'_to','type':'address'},{'name':'_value','type':'uint256'}],'name':'transfer','outputs':[{'name':'success','type':'bool'}],'payable':false,'stateMutability':'nonpayable','type':'function'},{'constant':false,'inputs':[{'name':'_from','type':'address'},{'name':'_to','type':'address'},{'name':'_value','type':'uint256'}],'name':'transferFrom','outputs':[{'name':'success','type':'bool'}],'payable':false,'stateMutability':'nonpayable','type':'function'},{'anonymous':false,'inputs':[{'indexed':true,'name':'_from','type':'address'},{'indexed':true,'name':'_to','type':'address'},{'indexed':false,'name':'_value','type':'uint256'}],'name':'Transfer','type':'event'},{'anonymous':false,'inputs':[{'indexed':true,'name':'_owner','type':'address'},{'indexed':true,'name':'_spender','type':'address'},{'indexed':false,'name':'_value','type':'uint256'}],'name':'Approval','type':'event'},{'constant':true,'inputs':[{'name':'_owner','type':'address'},{'name':'_spender','type':'address'}],'name':'allowance','outputs':[{'name':'remaining','type':'uint256'}],'payable':false,'stateMutability':'view','type':'function'},{'constant':true,'inputs':[{'name':'_owner','type':'address'}],'name':'balanceOf','outputs':[{'name':'balance','type':'uint256'}],'payable':false,'stateMutability':'view','type':'function'},{'constant':true,'inputs':[],'name':'decimals','outputs':[{'name':'','type':'uint256'}],'payable':false,'stateMutability':'view','type':'function'},{'constant':true,'inputs':[],'name':'name','outputs':[{'name':'','type':'string'}],'payable':false,'stateMutability':'view','type':'function'},{'constant':true,'inputs':[],'name':'symbol','outputs':[{'name':'','type':'string'}],'payable':false,'stateMutability':'view','type':'function'},{'constant':true,'inputs':[],'name':'totalSupply','outputs':[{'name':'','type':'uint256'}],'payable':false,'stateMutability':'view','type':'function'},{'constant':true,'inputs':[{'internalType':'address','name':'owner','type':'address'},{'internalType':'address','name':'spender','type':'address'}],'name':'allowance','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'payable':false,'stateMutability':'view','type':'function'}]",
		vTokenABI: "[{'constant':true,'inputs':[],'name':'exchangeRateStored','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'payable':false,'stateMutability':'view','type':'function'}]",
		strategyABI: "[{'inputs':[{'internalType':'address','name':'_govAddress','type':'address'},{'internalType':'address','name':'_afiFarmAddress','type':'address'},{'internalType':'address','name':'_AFIAddress','type':'address'},{'internalType':'address','name':'_wantAddress','type':'address'},{'internalType':'address','name':'_vTokenAddress','type':'address'},{'internalType':'address','name':'_uniRouterAddress','type':'address'}],'stateMutability':'nonpayable','type':'constructor'},{'anonymous':false,'inputs':[{'indexed':true,'internalType':'address','name':'previousOwner','type':'address'},{'indexed':true,'internalType':'address','name':'newOwner','type':'address'}],'name':'OwnershipTransferred','type':'event'},{'anonymous':false,'inputs':[{'indexed':false,'internalType':'address','name':'account','type':'address'}],'name':'Paused','type':'event'},{'anonymous':false,'inputs':[{'indexed':false,'internalType':'uint256','name':'_borrowRate','type':'uint256'},{'indexed':false,'internalType':'uint256','name':'_borrowDepth','type':'uint256'}],'name':'StratRebalance','type':'event'},{'anonymous':false,'inputs':[{'indexed':false,'internalType':'address','name':'account','type':'address'}],'name':'Unpaused','type':'event'},{'inputs':[],'name':'AFIAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'BORROW_DEPTH_MAX','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'BORROW_RATE_MAX','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'BORROW_RATE_MAX_HARD','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'afiFarmAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'borrowBal','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'borrowDepth','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'borrowRate','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'buyBackAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'buyBackRate','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'buyBackRateMax','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'buyBackRateUL','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'controllerFee','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'controllerFeeMax','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'controllerFeeUL','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'deleverageOnce','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'deleverageUntilNotOverLevered','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[{'internalType':'address','name':'_userAddress','type':'address'},{'internalType':'uint256','name':'_wantAmt','type':'uint256'}],'name':'deposit','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'earn','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'earnedAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'uint256','name':'','type':'uint256'}],'name':'earnedToAFIPath','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'entranceFeeFactor','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'entranceFeeFactorLL','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'entranceFeeFactorMax','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'bool','name':'_withLev','type':'bool'}],'name':'farm','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'govAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'address','name':'_token','type':'address'},{'internalType':'uint256','name':'_amount','type':'uint256'},{'internalType':'address','name':'_to','type':'address'}],'name':'inCaseTokensGetStuck','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'lastEarnBlock','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'owner','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'pause','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'paused','outputs':[{'internalType':'bool','name':'','type':'bool'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'uint256','name':'_borrowRate','type':'uint256'},{'internalType':'uint256','name':'_borrowDepth','type':'uint256'}],'name':'rebalance','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'renounceOwnership','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[{'internalType':'uint256','name':'_controllerFee','type':'uint256'}],'name':'setControllerFee','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[{'internalType':'uint256','name':'_entranceFeeFactor','type':'uint256'}],'name':'setEntranceFeeFactor','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[{'internalType':'address','name':'_govAddress','type':'address'}],'name':'setGov','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[{'internalType':'bool','name':'_onlyGov','type':'bool'}],'name':'setOnlyGov','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[{'internalType':'uint256','name':'_buyBackRate','type':'uint256'}],'name':'setbuyBackRate','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'sharesTotal','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'supplyBal','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'supplyBalMin','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'supplyBalTargeted','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'address','name':'newOwner','type':'address'}],'name':'transferOwnership','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'uniRouterAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'unpause','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'updateBalance','outputs':[],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'vTokenAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'venusAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'venusDistributionAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'uint256','name':'','type':'uint256'}],'name':'venusMarkets','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'uint256','name':'','type':'uint256'}],'name':'venusToWantPath','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'wantAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'wantIsWBNB','outputs':[{'internalType':'bool','name':'','type':'bool'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'wantLockedInHere','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'wantLockedTotal','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'view','type':'function'},{'inputs':[],'name':'wbnbAddress','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'address','name':'_userAddress','type':'address'},{'internalType':'uint256','name':'_wantAmt','type':'uint256'}],'name':'withdraw','outputs':[{'internalType':'uint256','name':'','type':'uint256'}],'stateMutability':'nonpayable','type':'function'},{'inputs':[],'name':'wrapBNB','outputs':[],'stateMutability':'nonpayable','type':'function'},{'stateMutability':'payable','type':'receive'}]",
	}
};

const AssetTypeEnum = {
	WBNB: "WBNB",
	BUSD: "BUSD",
	USDT: "USDT",
	USDC: "USDC",
	BTCB: "BTCB",
	ETH:"ETH",
	DOT: "DOT",
	LINK: "LINK",
	DAI: "DAI",
	CAKE: "CAKE",
	WBNB_CAKE_LP: "WBNB-CAKE LP",
	WBNB_BUSD_LP: "WBNB-BUSD LP",
	WBNB_BTCB_LP: "WBNB-BTCB LP",
	WBNB_ETH_LP: "WBNB-ETH LP",
	ETH_BETH_LP: "ETH-BETH LP",
	EGG_BUSD_LP: "EGG-BUSD LP",
	EGG_WBNB_LP: "EGG-WBNB LP",
	sBDO_BUSD_LP: "sBDO-BUSD LP",
	BDO_BUSD_LP: "BDO-BUSD LP",
};
const _source = [
	{
		poolId: "'0'",
		name: "AssetTypeEnum.USDC",
		feedAddrBSC: "'0x51597f405303C4377E36123cBc172b13269EA163'",
		tokenAddr: "'0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d'",
		vTokenAddr: "'0xecA88125a5ADbe82614ffC12D0DB554E2e2867C8'",
		strategyAddr: "'0xc544aed81017afff1c9f73453e4f7f0764aedecf'",
	},
	{
		poolId: "'1'",
		name: "AssetTypeEnum.DAI",
		feedAddrBSC: "'0x132d3C0B1D2cEa0BC552588063bdBb210FDeecfA'",
		tokenAddr: "'0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3'",
		vTokenAddr: "'0x334b3ecb4dca3593bccc3c7ebd1a1c1d1780fbf1'",
		strategyAddr: "'0xD10c18a39754eD7B1121B3ef234d9CE67895715F'",
	},
	{
		poolId: "'2'",
		name: "AssetTypeEnum.USDT",
		feedAddrBSC: "'0xB97Ad0E74fa7d920791E90258A6E2085088b4320'",
		tokenAddr: "'0x55d398326f99059ff775485246999027b3197955'",
		vTokenAddr: "'0xfD5840Cd36d94D7229439859C0112a4185BC0255'",
		strategyAddr: "'0x8d07436386C25F183fb8f20A29967DAFBBbBA218'",
	},
	{
		poolId: "'3'",
		name: "AssetTypeEnum.BTCB",
		feedAddrBSC: "'0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf'",
		tokenAddr: "'0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c'",
		vTokenAddr: "'0x882C173bC7Ff3b7786CA16dfeD3DFFfb9Ee7847B'",
		strategyAddr: "'0xeB16099617f2BC3EE6388D5C18429C4176213219'",
	},
	{
		poolId: "'4'",
		name: "AssetTypeEnum.ETH",
		feedAddrBSC: "'0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e'",
		tokenAddr: "'0x2170Ed0880ac9A755fd29B2688956BD959F933F8'",
		vTokenAddr: "'0xf508fCD89b8bd15579dc79A6827cB4686A3592c8'",
		strategyAddr: "'0xF9eB84B9DF44F336b61c9f6ebA6575f365c9cF61'",
	},
	{
		poolId: "'5'",
		name: "AssetTypeEnum.BUSD",
		feedAddrBSC: "'0xcBb98864Ef56E9042e7d2efef76141f15731B82f'",
		tokenAddr: "'0xe9e7cea3dedca5984780bafc599bd69add087d56'",
		vTokenAddr: "'0x95c78222B3D6e262426483D42CfA53685A67Ab9D'",
		strategyAddr: "'0x4F086ac8B4005b365d30C0571a2619A590D4F17e'",
	},
	{
		poolId: "'6'",
		name: "AssetTypeEnum.WBNB",
		feedAddrBSC: "'0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE'",
		tokenAddr: "'0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c'",
		vTokenAddr: "'0xA07c5b74C9B40447a954e1466938b865b6BBea36'",
		strategyAddr: "'0xbEC709bDb97139a6990c1383E82260e0487A7349'",
	},
	{
		poolId: "'7'",
		name: "AssetTypeEnum.DOT",
		feedAddrBSC: "'0xC333eb0086309a16aa7c8308DfD32c8BBA0a2592'",
		tokenAddr: "'0x7083609fce4d1d8dc0c979aab8c869ea2c873402'",
		vTokenAddr: "'0x1610bc33319e9398de5f57B33a5b184c806aD217'",
		strategyAddr: "'0x917676E2476f3409444B0c3EACC34fE99939fDc9'",
	},
	{
		poolId: "'8'",
		name: "AssetTypeEnum.LINK",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd'",
		vTokenAddr: "'0x650b940a1033B8A1b1873f78730FcFC73ec11f1f'",
		strategyAddr: "'0x5D1ED162273bBb905ACc8b92bb37282d33BDb045'",
	},
	{
		poolId: "'11'",
		name: "AssetTypeEnum.WBNB_BUSD_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0x1b96b92314c44b159149f7e0303511fb2fc4774f'",
		vTokenAddr: "'0x73feaa1eE314F8c655E354234017bE2193C9E24E'",
		strategyAddr: "'0x62555be399F19f87a66719ACDF55FFa83361d073'",
	},
	{
		poolId: "'12'",
		name: "AssetTypeEnum.WBNB_CAKE_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0xA527a61703D82139F8a06Bc30097cC9CAA2df5A6'",
		vTokenAddr: "'0x73feaa1eE314F8c655E354234017bE2193C9E24E'",
		strategyAddr: "'0xF8b9E3430981f8Fb00A6f6F3D5B5A550B2B378c6'",
	},
	{
		poolId: "'13'",
		name: "AssetTypeEnum.WBNB_BTCB_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0x7561EEe90e24F3b348E1087A005F78B4c8453524'",
		vTokenAddr: "'0x73feaa1eE314F8c655E354234017bE2193C9E24E'",
		strategyAddr: "'0xBF76248d5e3bfd1d4dDE4369Fe6163289A0267F6'",
	},
	{
		poolId: "'14'",
		name: "AssetTypeEnum.WBNB_ETH_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0x70D8929d04b60Af4fb9B58713eBcf18765aDE422'",
		vTokenAddr: "'0x73feaa1eE314F8c655E354234017bE2193C9E24E'",
		strategyAddr: "'0x9605cD5b9E841c54E478F72C008356eb4B221E9B'",
	},
	{
		poolId: "'15'",
		name: "AssetTypeEnum.ETH_BETH_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0x99d865ed50d2c32c1493896810fa386c1ce81d91'",
		vTokenAddr: "'0x73feaa1eE314F8c655E354234017bE2193C9E24E'",
		strategyAddr: "'0x5037606A9D4d01457f3Bdf9f3e955fC56A322809'",
	},
	{
		poolId: "'16'",
		name: "AssetTypeEnum.EGG_BUSD_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0x19e7cbecdd23a16dfa5573df54d98f7caae03019'",
		vTokenAddr: "'0xe70E9185F5ea7Ba3C5d63705784D8563017f2E57'",
		strategyAddr: "'0x69a9Ebd70f1081C1F7abC07c268E3D948Fae484B'",
	},
	{
		poolId: "'17'",
		name: "AssetTypeEnum.EGG_WBNB_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0xd1b59d11316e87c3a0a069e80f590ba35cd8d8d3'",
		vTokenAddr: "'0xe70E9185F5ea7Ba3C5d63705784D8563017f2E57'",
		strategyAddr: "'0xEf57dA6a318FFb36072CC98d8A1A2a66852b4aB4'",
	},
	{
		poolId: "'18'",
		name: "AssetTypeEnum.sBDO_BUSD_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0xa0718093baa3e7aae054eed71f303a4ebc1c076f'",
		vTokenAddr: "'0x948dB1713D4392EC04C86189070557C5A8566766'",
		strategyAddr: "'0x605c94aa5D185f2E42E75F71EC29982859D08Be7'",
	},
	{
		poolId: "'19'",
		name: "AssetTypeEnum.BDO_BUSD_LP",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0xc5b0d73A7c0E4eaF66baBf7eE16A2096447f7aD6'",
		vTokenAddr: "'0x948dB1713D4392EC04C86189070557C5A8566766'",
		strategyAddr: "'0x7f820A1b7cfE1776d5eb6Ed3cEE7841D96334987'",
	},
	{
		poolId: "'20'",
		name: "AssetTypeEnum.CAKE",
		feedAddrBSC: "'0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8'",
		tokenAddr: "'0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82'",
		vTokenAddr: "'0x73feaa1eE314F8c655E354234017bE2193C9E24E'",
		strategyAddr: "'0x2E9F5B9Dc789948DB41E355506c6d85912f7D90b'",
	},
];
const data = [];

_source.forEach((value, index, array) => {
	data.push(jsonTemplate(index, value.poolId, value.name, "'auto-compounding'", "'Venus'", value.feedAddrBSC, value.tokenAddr, value.strategyAddr, value.vTokenAddr))
});

const formatJSON = JSON.stringify(data)
	.replace(/:/g, " : ");

fs.mkdirSync(`_generationV2/Outcome`, { recursive: true });
fs.writeFileSync(
	path.resolve(`_generationV2/Outcome/index.js`),
	`const assetInfo = () => ${formatJSON}`,
	{flag: "w+"}
);