import Decimal from "decimal.js";
import rp from "request-promise";
import Web3 from 'web3';
import config from '../config/example.config';
import {
    CONFIGURE, ERROR,
    EXIT, GET_REWARDS,
    GET_REWARDS_RETURNED, GET_STAKE_APY_DETAIL,
    GET_STAKE_APY_DETAIL_DONE,
    STAKE,
    STAKE_RETURNED,
    UPDATE_APY_DETAIL, WITHDRAW,
    WITHDRAW_RETURNED
} from "../constants/constants-extension";
import stakePools from "../setting/stake";
import store from "./store";

const Emitter = require('events').EventEmitter;
const emitter = new Emitter();

export const StoreExtension = (clazz, dispatcher) => {

    const _stakeBalance = async (web3, asset, account) => {
        const erc20Contract = new web3.eth.Contract(config.erc20ABI, asset.address);

        const balance = await erc20Contract.methods.balanceOf(account.address)
            .call({ from: account.address });
        // console.log(balance, parseFloat(balance)/10**asset.decimals, new Decimal(balance).toFixed(12), "_stakeBalance ==");
        return new Decimal(parseFloat(balance)/10**asset.decimals).toFixed();
    };

    const _stakedBalance = async (web3, asset, account) => {
        let erc20Contract = new web3.eth.Contract(asset.rewardsABI, asset.rewardsAddress);

        let balance = await erc20Contract.methods.balanceOf(account.address)
            .call({ from: account.address });
        // console.log(balance, parseFloat(balance)/10**asset.decimals, new Decimal(balance).toFixed(12), "_stakedBalance ==");
        return new Decimal(parseFloat(balance)/10**asset.decimals).toFixed();
    };

    const _stakeRewards = async (web3, asset, account) => {
        let erc20Contract = new web3.eth.Contract(asset.rewardsABI, asset.rewardsAddress);

        let balance = await erc20Contract.methods.earned(account.address)
            .call({ from: account.address });
        // console.log(balance, parseFloat(balance)/10**asset.rewardDecimals, new Decimal(balance).toFixed(12), "_stakeRewards ==");
        return new Decimal(parseFloat(balance)/10**asset.rewardDecimals).toFixed();
    };

    // stake page details
    clazz.store.stakePools = stakePools;

    clazz.stakeAPYDetail = async () => {
        // console.log("stakeAPYDetail ==")
        let timeoutObj;
        let missionCount = 0;
        const account = clazz.store.account;
        const web3 = new Web3(clazz.store.web3context.library.provider);
        const ariesAPYs = await clazz.getAriesAPYs();
        // console.log(clazz.store.stakePools, "newStakePools - start ==");
        clazz.store.stakePools.forEach((pool) => {
            pool.tokens.forEach(async (token) => {
                // console.log(token, `${pool.name} pool - tokens - start ==`);
                token.balance = await _stakeBalance(web3, token, account);
                token.stakedBalance = await _stakedBalance(web3, token, account);
                token.rewardsAvailable = await _stakeRewards(web3, token, account);
                token.ariesAPY = await clazz.getAriesAPY(ariesAPYs, token);
                missionCount++;
                // console.log(token, `${pool.name} pool - tokens - end ==`);
            });
        });
        timeoutObj = setInterval(() => {
            if(missionCount === 5) {
                clearInterval(timeoutObj);
                store.emitter.emit(GET_STAKE_APY_DETAIL_DONE);
                // console.log(clazz.store.stakePools, "newStakePools - end ==");
            }
        }, 1000)
    };

    clazz.updateStakeAPYDetail = async (payload) => {
        // console.log(payload.content.asset, "updateStakeAPYDetail - start ==");
        const web3 = new Web3(clazz.store.web3context.library.provider);
        const account = clazz.store.account;
        const asset = payload.content.asset;

        const balance = await _stakeBalance(web3, asset, account);
        const stakedBalance = await _stakedBalance(web3, asset, account);
        const rewardsAvailable = await _stakeRewards(web3, asset, account);

        asset.balance = balance;
        asset.stakedBalance = stakedBalance;
        asset.rewardsAvailable = rewardsAvailable;
        // console.log(payload.content, "updateStakeAPYDetail - end ==");
        // console.log(clazz.store.stakePools);
        setTimeout(()=>{
            // console.log("emit - GET_STAKE_APY_DETAIL_DONE ==");
            store.emitter.emit(GET_STAKE_APY_DETAIL_DONE);
        }, 1000);
    };

    clazz.stake = (payload) => {
        const account = clazz.store.account;
        const { asset, amount } = payload.content;
        clazz._stakeCheckApproval(asset, account, amount, asset.rewardsAddress, (err) => {
            if (err) return emitter.emit(ERROR, err);
            clazz._stakeCallStake(asset, account, amount, payload, (err, res) => {
                if (err) return emitter.emit(ERROR, err);
                return emitter.emit(STAKE_RETURNED, res)
            }).then(r => r)
        }).then(r => r);
    };

    clazz._stakeCheckApproval = async (asset, account, amount, contract, callback) => {
        // console.log(asset, account, amount, "Stake - checkApproval - start==");
        try {
            const web3 = new Web3(clazz.store.web3context.library.provider);

            const erc20Contract = new web3.eth.Contract(asset.abi, asset.address)
            const allowance = await erc20Contract.methods.allowance(account.address, contract)
                .call({ from: account.address });

            const ethAllowance = web3.utils.fromWei(allowance, "ether")

            if(parseFloat(ethAllowance) < parseFloat(amount)) {
                await erc20Contract.methods.approve(contract, web3.utils.toWei("999999999999999", "ether"))
                    .send({
                        from: account.address,
                        gasPrice: web3.utils.toWei(await clazz._stakeGetGasPrice(), 'gwei')
                    });
                callback()
            } else {
                callback()
            }
        } catch(error) {
            // console.log(asset, account, amount, error, "Stake - checkApproval - error==");
            if(error.message) {
                return callback(error.message)
            }
            callback(error)
        }
        // console.log(asset, account, amount, "Stake - checkApproval - end==");
    }

    clazz._stakeCallStake = async (asset, account, amount, payload, callback) => {
        // console.log(asset, account, amount, "Stake - callStake - start==");
        const web3 = new Web3(clazz.store.web3context.library.provider);

        const rewardContract = new web3.eth.Contract(asset.rewardsABI, asset.rewardsAddress)

        let amountToSend = web3.utils.toWei(amount, "ether");
        if (asset.decimals !== 18) {
            amountToSend = (amount*10**asset.decimals).toFixed(0);
        }

        rewardContract.methods.stake(amountToSend).send({
            from: account.address,
            gasPrice: web3.utils.toWei(await clazz._stakeGetGasPrice(),
            'gwei')
        })
            .on('transactionHash', function(hash){
                console.log(hash, "Stake - transactionHash==");
                callback(null, hash)
            })
            .on('confirmation', function(confirmationNumber, receipt){
                console.log(confirmationNumber, receipt, "Stake - confirmation==");
                if(confirmationNumber === 2) {
                    console.log(receipt, "Stake - updateStakeAPYDetail==");
                    clazz.updateStakeAPYDetail(payload);
                }
            })
            .on('receipt', function(receipt){
                console.log(receipt, "Stake - receipt==");
            })
            .on('error', function(error) {
                console.log(error, "Stake - error==");
                if (!error.toString().includes("-32601")) return error.message ? callback(error.message) : callback(error);
            })
            .catch((error) => {
                console.log(error, "Stake - catch - error==");
                if (!error.toString().includes("-32601")) return error.message ? callback(error.message) : callback(error);
            });
        // console.log(asset, account, amount, "Stake - callStake - end==");
    };

    clazz._stakeGetGasPrice = async () => {
        try {
            // todo: get real Gas Price
            const url = 'https://gasprice.poa.network/'
            const priceString = await rp(url);
            const priceJSON = JSON.parse(priceString)
            if(priceJSON) {
                return priceJSON.fast.toFixed(0)
            }
            return clazz.store.universalGasPrice
        } catch(e) {
            console.error(e);
            return clazz.store.universalGasPrice
        }
    };

    clazz.stakeWithdraw = async (payload) => {
        // console.log("stakeWithdraw - start ==");
        const account = clazz.store.account;
        const { asset, amount } = payload.content;

        await clazz._stakeCallWithdraw(asset, account, amount, payload, (err, res) => {
            // console.log(asset, account, amount, "UnStake - stakeCallWithdraw - start==");
            if (err) return emitter.emit(ERROR, err);
            // console.log(asset, account, amount, "UnStake - stakeCallWithdraw - end==");
            return emitter.emit(WITHDRAW_RETURNED, res)
        });
        // console.log("stakeWithdraw - end ==");
    };

    clazz._stakeCallWithdraw = async (asset, account, amount, payload, callback) => {
        const web3 = new Web3(clazz.store.web3context.library.provider);

        const contract = new web3.eth.Contract(asset.rewardsABI, asset.rewardsAddress)

        let amountToSend = web3.utils.toWei(amount, "ether");
        if (asset.decimals !== 18) {
            amountToSend = (amount*10**asset.decimals).toFixed(0);
        }

        await contract.methods.withdraw(amountToSend).send({ from: account.address, gasPrice: web3.utils.toWei(await clazz._getGasPrice(), 'gwei') })
            .on('transactionHash', function(hash){
                console.log(hash, "UnStake - transactionHash==");
                callback(null, hash)
            })
            .on('confirmation', function(confirmationNumber, receipt){
                console.log(confirmationNumber, receipt, payload, "UnStake - confirmation==");
                if(confirmationNumber === 2) {
                    clazz.updateStakeAPYDetail(payload);
                }
            })
            .on('error', function(error) {
                console.log(error, "UnStake - error==");
                if (!error.toString().includes("-32601")) {
                    if(error.message) {
                        return callback(error.message)
                    }
                    callback(error)
                }
            })
            .catch((error) => {
                console.log(error, "UnStake - catch==");
                if (!error.toString().includes("-32601")) {
                    if(error.message) {
                        return callback(error.message)
                    }
                    callback(error)
                }
            })
    };

    clazz.stakeRewards = async (payload) => {
        console.log("stakeRewards - start ==")
        const token = payload.content.tokens[0];
        const web3 = new Web3(clazz.store.web3context.library.provider);
        const account = clazz.store.account;

        const contract = new web3.eth.Contract(token.rewardsABI, token.rewardsAddress)
        contract.methods.getReward().send({ from: account.address, gasPrice: web3.utils.toWei(await clazz._getGasPrice(), 'gwei') })
            .on('transactionHash', function(hash){
                console.log(hash, "stakeRewards - transactionHash ==")
            })
            .on('confirmation', function(confirmationNumber, receipt){
                console.log(confirmationNumber, receipt, "stakeRewards - confirmation ==")
                if(confirmationNumber === 2) clazz.updateStakeAPYDetail(payload);
            })
            .on('receipt', function(receipt){
                console.log(receipt, "stakeRewards - confirmation ==")
            })
            .on('error', function(error) {
                console.log(error, "stakeRewards - error ==")
            });
        console.log("stakeRewards - end ==");
        emitter.emit(GET_REWARDS_RETURNED, "You have got your reward");
    };

    /**
    * execute stakeExit and stakeWithdraw
    * */
    clazz.stakeExit = async (payload) => {
        console.log(payload, "stakeExit ==");
        const asset = payload.content.tokens[0];
        payload.content.asset = asset;
        payload.content.amount = asset.stakedBalance;
        clazz.stakeWithdraw(payload).then(r => clazz.stakeRewards(payload));
    };

    /**
     {
      "code": "0",
      "mesg": "ok",
      "data": [
          {
              "pool_identifier": "AFI Governance Pool",
              "liquidity_lock": "36618.52919",
              "apy": "44102.552"
          },
          {
              "pool_identifier": "UniLP_AFI_USDC Pool",
              "liquidity_lock": "5575",
              "apy": "318555.138304"
          },
          {
              "pool_identifier": "afiUSDC Pool",
              "liquidity_lock": "94219.97928",
              "apy": "2792.07968"
          },
          {
              "pool_identifier": "afiUSDT Pool",
              "liquidity_lock": "57866.19095",
              "apy": "4560.973664"
          },
          {
              "pool_identifier": "afiDAI Pool",
              "liquidity_lock": "62931.47018",
              "apy": "5309.72182"
          }
      ]
  }
     * */
    clazz.getAriesAPYs = async () => {
        const response = await fetch(`${config.apiURLProvider}pools`)
            .then(r=>r.json());
        return response;
    };

    clazz.getAriesAPY = async (ariesAPY, asset) => {
        const result = ariesAPY.data.filter((value) => {
            return value.pool_identifier === asset.pool_identifier;
        });
        const apy = result.length > 0 && result[0].apy ? result[0].apy : 0
        console.log(apy, "_getAriesAPY ==");
        return apy*1;
    };

    dispatcher.register(
        function (payload) {
            console.log(payload, "payload ==");
            switch (payload.type) {
                case GET_STAKE_APY_DETAIL:
                    clazz.stakeAPYDetail(payload);
                    break;
                case GET_STAKE_APY_DETAIL_DONE:
                    break;
                case STAKE:
                    clazz.stake(payload);
                    break;
                case WITHDRAW:
                    clazz.stakeWithdraw(payload);
                    break;
                case CONFIGURE:
                    console.log("Do CONFIGURE", "==");
                    break;
                case GET_REWARDS:
                    clazz.stakeRewards(payload);
                    break;
                case EXIT:
                    clazz.stakeExit(payload);
                    break;
                case UPDATE_APY_DETAIL:
                    clazz.updateStakeAPYDetail(payload);
                    break;
                default:
                    console.log("Do nothing", "==");
            }
        }.bind(clazz)
    );
    // console.log("StoreExtension init gets done", "==");
    return clazz;
};