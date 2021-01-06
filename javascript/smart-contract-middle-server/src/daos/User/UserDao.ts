import {IUser} from '@entities/User';
import logger from '@shared/Logger';
import Decimal from "decimal.js";
import ethers from 'ethers';
import {ContractConfig, ContractInterface} from "../../config/contract";

export interface IUserDao {
    getAFIStakedBalance: (address: string, assetId: string) => Promise<any>;
    getAFIBonusReward: (address: string, assetId: string) => Promise<any>;
    getOne: (email: string) => Promise<IUser | null>;
    getAll: () => Promise<IUser[]>;
    add: (user: IUser) => Promise<IUser>;
    update: (user: IUser) => Promise<IUser>;
    delete: (id: number) => Promise<IUser>;
}

export default class UserDao implements IUserDao {

    smartContract = async (contractInfo: ContractInterface): Promise<string> => {
        if(contractInfo.method != null && contractInfo.address != null){
            const contract = new ethers.Contract(contractInfo.contractAddress, contractInfo.contractAbi, contractInfo.provider)
            const balance = await contract[contractInfo.method]();
            return new Decimal(parseFloat(balance) / 10 ** contractInfo.decimals).toFixed();
        } else {
            return "-1";
        }
    }

    public async getAFIStakedBalance(address: string, assetId: string): Promise<string> {
        const contractInfo: ContractInterface[] = ContractConfig.filter(asset => (asset.id == assetId));
        if(contractInfo.length > 0 ){
            contractInfo[0].address = address;
            contractInfo[0].method = "balanceOf";
            logger.info(`getAFIStakedBalance: ${contractInfo}`);
            return await this.smartContract(contractInfo[0]);
        } else {
            return "-1";
        }
    }

    public async getAFIBonusReward(address: string, assetId: string): Promise<string> {
        const contractInfo: ContractInterface[] = ContractConfig.filter(asset => (asset.id == assetId));
        if(contractInfo.length > 0 ){
            contractInfo[0].address = address;
            contractInfo[0].method = "earned";
            logger.info(`getAFIBonusReward: ${contractInfo}`);
            return await this.smartContract(contractInfo[0]);
        } else {
            return "-1";
        }
    }

    /**
     * @param email
     */
    public async getOne(email: string): Promise<IUser | null> {
        // TODO
        logger.info(`UserDao - getOne : ${email}`);
        return Promise.resolve(null);
    }


    /**
     *
     */
    public async getAll(): Promise<IUser[]> {
         // TODO
        return Promise.resolve([]);
    }


    /**
     *
     * @param user
     */
    public async add(user: IUser): Promise<IUser> {
         // TODO
        logger.info(`UserDao - getOne :` + user);
        return Promise.resolve(user);
    }


    /**
     *
     * @param user
     */
    public async update(user: IUser): Promise<IUser> {
         // TODO
        logger.info(`UserDao - getOne :` + user);
        return Promise.resolve(user);
    }


    /**
     *
     * @param id
     */
    public async delete(id: number): Promise<IUser> {
        const user: IUser = {} as IUser;
         // TODO
        logger.info(`UserDao - getOne : ${id}`);
        return Promise.resolve(user);
    }
}