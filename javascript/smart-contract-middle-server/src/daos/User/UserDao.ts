import { IUser } from '@entities/User';
import logger from '@shared/Logger';

export interface IUserDao {
    getOne: (email: string) => Promise<IUser | null>;
    getAll: () => Promise<IUser[]>;
    add: (user: IUser) => Promise<IUser>;
    update: (user: IUser) => Promise<IUser>;
    delete: (id: number) => Promise<IUser>;
}

class UserDao implements IUserDao {

    /**
     * @param email
     */
    public getOne(email: string): Promise<IUser | null> {
        // TODO
        logger.info(`UserDao - getOne : ${email}`);
        return Promise.resolve(null);
    }


    /**
     *
     */
    public getAll(): Promise<IUser[]> {
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

export default UserDao;
