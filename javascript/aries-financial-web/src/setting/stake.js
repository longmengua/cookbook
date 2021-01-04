import { config } from "../config/example.config.extension";

const stakePools = [
  {
    name: "UniLP_AFI_USDC Pool",
    deposit: "UNI-V2",
    pool: "Uni AFIUSDC LP Staking",
    reward: "AFI token",
    depositUrl: "https://info.uniswap.org/pair/0xb6a0d0406772ac3472dc3d9b7a2ba4ab04286891",
    poolUrl: "https://etherscan.io/address/0xd40cade3f71c20ba6fe940e431c890dc100e97d6",
    rewardUrl: "https://etherscan.io/address/0xd40cade3f71c20ba6fe940e431c890dc100e97d6",
    depositsEnabled: true,
    rewardedWeekDay: 3, //start from 0 to 6, which is Sunday to Saturday.
    tokens: [
      {
        id: 'UNI-V2',
        pool_identifier: "UniLP_AFI_USDC Pool",
        address: '0xb6a0d0406772ac3472dc3d9b7a2ba4ab04286891',
        symbol: 'uni.png',
        depositToken: "UNI-V2",
        abi: config.uniABI,
        decimals: 18,
        rewardDecimals: 18,
        rewardsAddress: config.unipoolAddress,
        rewardsABI: config.unipoolABI,
        rewardsSymbol: 'aries.png',
        balance: 0,
        stakedBalance: 0,
        rewardsAvailable: 0,
        ariesAPY: 0,
      }
    ]
  },
  {
    name: "AFI Governance Pool",
    deposit: "AFI",
    pool: "AFI Staking",
    reward: "AFI token",
    depositUrl: "https://app.uniswap.org/#/swap?inputCurrency=0x68e8a20128e1902c02f533a02ed0cfd8396e3fbc&outputCurrency=0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48",
    poolUrl: "https://etherscan.io/address/0x9cd43309c9e122a13b466391babc5dec8be1e01e",
    rewardUrl: "https://etherscan.io/address/0x9cd43309c9e122a13b466391babc5dec8be1e01e",
    depositsEnabled: true,
    rewardedWeekDay: 3, //start from 0 to 6, which is Sunday to Saturday.
    tokens: [
      {
        id: 'AFI',
        pool_identifier: "AFI Governance Pool",
        address: '0x68E8A20128e1902C02f533a02eD0cFd8396E3Fbc',
        symbol: 'aries.png',
        depositToken: "AFI",
        abi: config.afiABI,
        decimals: 18,
        rewardDecimals: 18,
        rewardsAddress: config.governanceAddress,
        rewardsABI: config.governanceABI,
        rewardsSymbol: 'aries.png',
        balance: 0,
        stakedBalance: 0,
        rewardsAvailable: 0,
        ariesAPY: 0,
      }
    ]
  },
  {
    name: "afiUSDC Pool",
    deposit: "afiUSDC",
    pool: "afiUSDC Staking",
    reward: "AFI token",
    depositUrl: "https://www.aries.financial/farming",
    poolUrl: "https://etherscan.io/address/0xac7de028cce2a99e9399ab0be198bc950994f50c#readContract",
    rewardUrl: "https://etherscan.io/address/0xac7de028cce2a99e9399ab0be198bc950994f50c",
    depositsEnabled: true,
    rewardedWeekDay: 3, //start from 0 to 6, which is Sunday to Saturday.
    tokens: [
      {
        id: 'afiUSDC',
        pool_identifier: "afiUSDC Pool",
        address: '0xfC64d0bF54351d4383713172090F070836748590',
        symbol: 'aries.png',
        depositToken: "afiUSDC",
        abi: config.afUSDCABI,
        decimals: 6,
        rewardDecimals: 18,
        rewardsAddress: config.afusdcpoolAddress,
        rewardsABI: config.afusdcpoolABI,
        rewardsSymbol: 'aries.png',
        balance: 0,
        stakedBalance: 0,
        rewardsAvailable: 0,
        ariesAPY: 0,
      }
    ]
  },
  {
    name: "afiUSDT Pool",
    deposit: "afiUSDT",
    pool: "afiUSDT Staking",
    reward: "AFI token",
    depositUrl: "https://www.aries.financial/farming",
    poolUrl: "https://etherscan.io/address/0x825241bA78700c11a4615523dF4B70F78C7384aa#readContract",
    rewardUrl: "https://etherscan.io/address/0x825241bA78700c11a4615523dF4B70F78C7384aa",
    depositsEnabled: true,
    rewardedWeekDay: 3, //start from 0 to 6, which is Sunday to Saturday.
    tokens: [
      {
        id: 'afiUSDT',
        pool_identifier: "afiUSDT Pool",
        address: '0x0Ea9f8C451f472e9f9463d76097b8D0821CF1A55',
        symbol: 'aries.png',
        depositToken: "afiUSDT",
        abi: config.afUSDTABI,
        decimals: 6,
        rewardDecimals: 18,
        rewardsAddress: config.afusdtpoolAddress,
        rewardsABI: config.afusdtpoolABI,
        rewardsSymbol: 'aries.png',
        balance: 0,
        stakedBalance: 0,
        rewardsAvailable: 0,
        ariesAPY: 0,
      }
    ]
  },
  {
    name: "afiDAI Pool",
    deposit: "afiDAI",
    pool: "afiDAI Staking",
    reward: "AFI token",
    depositUrl: "https://www.aries.financial/farming",
    poolUrl: "https://etherscan.io/address/0x8667D16150AcAA1FF19AcC5E5c64Bf0Ba1d551b3#readContract",
    rewardUrl: "https://etherscan.io/address/0x8667D16150AcAA1FF19AcC5E5c64Bf0Ba1d551b3",
    depositsEnabled: true,
    rewardedWeekDay: 3, //start from 0 to 6, which is Sunday to Saturday.
    tokens: [
      {
        id: 'afiDAI',
        pool_identifier: "afiDAI Pool",
        address: '0xfE170Dd8F4C0f335326dF1892D75de47c8d2CBC1',
        symbol: 'aries.png',
        depositToken: "afiDAI",
        abi: config.afiDAIABI,
        decimals: 18,
        rewardDecimals: 18,
        rewardsAddress: config.afidaipoolAddress,
        rewardsABI: config.afidaipoolABI,
        rewardsSymbol: 'aries.png',
        balance: 0,
        stakedBalance: 0,
        rewardsAvailable: 0,
        ariesAPY: 0,
      }
    ]
  }
];

export default stakePools;
