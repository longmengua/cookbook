const TOKEN_DATA = [
	{
		id          : 1,
		symbol      : 'aWETH',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/ETH-icon.png',
		decimals    : 18,
		tokenAddress: '0x25B192d931dD8e473A2F2B53D8BB02b83aE6A4b0'
	},
	{
		id          : 2,
		symbol      : 'AFI',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/FTM-logo.png',
		decimals    : 18,
		tokenAddress: '0xdE726E878373A321d788e361a368F26AB398A7D4'
	},
	{
		id          : 3,
		symbol      : 'afi3Crv',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/KNC-logo.png',
		decimals    : 18,
		tokenAddress: '0xf908a9B8Bc339221813Af9C7E380CE845964E266'
	},
	{
		id          : 4,
		symbol      : 'afiUSD',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x47561aADd55b829C9756CD8fE0016eCAD88dFbDC'
	},
	{
		id          : 5,
		symbol      : 'afiCrvBUSD',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x129C86C01abAE3d2C90B4507E62B33F0617ccB34'
	},
	{
		id          : 6,
		symbol      : 'afiCrvBTC',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xFfD0662a840bdE1403CDcc090Fc7157b06c86219'
	},
	{
		id          : 7,
		symbol      : 'afiDAI',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xe0469D912c781e727a365fE89D8BcfF0de654BB7'
	},
	{
		id          : 8,
		symbol      : 'afiTUSD',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x218911E240f4CCAEa0839e3f1f992E3aCb692Ad6'
	},
	{
		id          : 9,
		symbol      : 'afiUSDC',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x0279eF39C3029af541cbabCF8e83Afa0c96E8782'
	},
	{
		id          : 10,
		symbol      : 'afiUSDT',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xfdAF86cBa91672e81dA03D2f4Fe951505EE4F468'
	},
	{
		id          : 11,
		symbol      : 'afiaLink',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x0948e8aea2E4539a300E92911B5C12ea6B6A299f'
	},
	{
		id          : 12,
		symbol      : '3Crv',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x6c3F90f043a72FA612cbac8115EE7e52BDe6E490'
	},
	{
		id          : 13,
		symbol      : 'yCRV',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xdF5e0e81Dff6FAF3A7e52BA697820c5e32D806A8'
	},
	{
		id          : 14,
		symbol      : 'crvBUSD',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x3B3Ac5386837Dc563660FB6a0937DFAa5924333B'
	},
	{
		id          : 15,
		symbol      : 'crvBTC',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x075b1bb99792c9E1041bA13afEf80C91a1e70fB3'
	},
	{
		id          : 16,
		symbol      : 'UniLP_USDC_AFI',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xB6A0D0406772aC3472dC3D9B7A2BA4AB04286891'
	},
	{
		id          : 17,
		symbol      : 'BalancerLP_USDC_AFI',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x9820436bF37E2A38a3cEc78161335D1A081321dD'
	},
	{
		id          : 18,
		symbol      : 'Uni_ETH_USDT',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852'
	},
	{
		id          : 19,
		symbol      : 'Uni_ETH_USDC',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc'
	},
	{
		id          : 20,
		symbol      : 'Uni_ETH_DAI',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xA478c2975Ab1Ea89e8196811F51A7B7Ade33eB11'
	},
	{
		id          : 21,
		symbol      : 'Uni_ETH_WBTC',
		imageURL    : 'https://s3-ap-southeast-1.amazonaws.com/public-assets.aries.financial/BAT-logo.png',
		decimals    : 18,
		tokenAddress: '0xBb2b8038a1640196FbE3e38816F3e67Cba72D940'
	},

];

export default TOKEN_DATA;

/**

        <Table>
          <TableBody>
            <TableRow>
              <TableCell>Logo</TableCell>
              <TableCell>Symbol</TableCell>
              <TableCell>Decimals</TableCell>
            </TableRow>
          </TableBody>
        </Table>

        <Table>
          <TableBody>
            <TableRow>
              <TableCell>
                <img src={tokenImage || logo} className="logo" alt="Coin"/>
              </TableCell>
              <TableCell>{tokenSymbol}</TableCell>
              <TableCell>{tokenDecimals}</TableCell>
            </TableRow>
          </TableBody>
        </Table>


*/