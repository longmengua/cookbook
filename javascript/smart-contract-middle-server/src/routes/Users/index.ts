import StatusCodes from 'http-status-codes';
import {Request, Response, Router} from 'express';

import UserDao, {IUserDao} from '@daos/User/UserDao';
import { paramMissingError } from '@shared/constants';
import {IUser} from "@entities/User";
import logger from "@shared/Logger";

const router = Router();
const { BAD_REQUEST, CREATED, OK, INTERNAL_SERVER_ERROR } = StatusCodes;
const userDao: IUserDao = new UserDao();


/******************************************************************************
 *  Get Balance with User's Wallet address and pool address - "GET /api/users/all"
 *
 *  @apiNote Content-Type must be set as application/json in request header
 ******************************************************************************/

router.post('/balance', async (req: Request, res: Response): Promise<Response> => {
    logger.info(`/balance, req: ${req.body}`);
    try{
        const { walletAddress, assetId } = req.body;
        const result = await userDao.getAFIStakedBalance(walletAddress, assetId);
        return res.status(OK).json(result);
    } catch (e){
        return res.status(INTERNAL_SERVER_ERROR).json(e);
    }
});



/******************************************************************************
 *  Get Bonus Reward with User's Wallet address and pool address - "GET /api/users/all"
 *
 *  @apiNote Content-Type must be set as application/json in request header
 ******************************************************************************/

router.post('/bonus', async (req: Request, res: Response): Promise<Response> => {
    logger.info(`/bonus, req: ${req.body}`);
    try{
        const {walletAddress, assetId} = req.body;
        const result = await userDao.getAFIBonusReward(walletAddress, assetId);
        return res.status(OK).json(result);
    }catch (e) {
        return res.status(INTERNAL_SERVER_ERROR).json(e);
    }
});



/******************************************************************************
 *                      Get All Users - "GET /api/users/all"
 ******************************************************************************/

router.get('/all', async (req: Request, res: Response): Promise<Response> => {
    const data: IUser[] = [];
    logger.info('/all' + data);
    return res.status(OK).json(data);
});



/******************************************************************************
 *                       Add One - "POST /api/users/add"
 *
 *   @apiNote Content-Type must be set as application/json in request header
 ******************************************************************************/

router.post('/add', async (req: Request, res: Response): Promise<Response> => {
    const { user } = req.body;
    if (!user) {
        return res.status(BAD_REQUEST).json({
            error: paramMissingError,
        });
    }
    const data: IUser = {} as IUser;
    logger.info('/add' + data);
    return res.status(CREATED).json(data);
});



/******************************************************************************
 *                       Update - "PUT /api/users/update"
 *
 *   @apiNote Content-Type must be set as application/json in request header
 ******************************************************************************/

router.put('/update', async (req: Request, res: Response): Promise<Response> => {
    const { user } = req.body;
    if (!user) {
        return res.status(BAD_REQUEST).json({
            error: paramMissingError,
        });
    }
    user.id = Number(user.id);
    const data: IUser = {} as IUser;
    logger.info('/update' + data);
    return res.status(OK).json(data);
});



/******************************************************************************
 *                    Delete - "DELETE /api/users/delete/:id"
 ******************************************************************************/

router.delete('/delete/:id', async (req: Request, res: Response): Promise<Response> => {
    const { id } = req.params;
    const data: IUser = {} as IUser;
    logger.info('/delete' + data);
    return res.status(OK).json(data);
});



/******************************************************************************
 *                                     Export
 ******************************************************************************/

export default router;
