import StatusCodes from 'http-status-codes';
import {Request, Response, Router} from 'express';

import UserDao from '@daos/User/UserDao.mock';
import {IRequest, paramMissingError} from '@shared/constants';
import {IUser} from "@entities/User";

const router = Router();
const userDao = new UserDao();
const { BAD_REQUEST, CREATED, OK } = StatusCodes;



/******************************************************************************
 *  Get Balance with User's Wallet address and pool address - "GET /api/users/all"
 ******************************************************************************/

router.get('/balance', async (req: Request, res: Response): Promise<Response> => {

    return res.status(OK).json("balance");
});



/******************************************************************************
 *  Get Bonus Reward with User's Wallet address and pool address - "GET /api/users/all"
 ******************************************************************************/

router.get('/bonus', async (req: Request, res: Response): Promise<Response> => {

    return res.status(OK).json("bonus");
});



/******************************************************************************
 *                      Get All Users - "GET /api/users/all"
 ******************************************************************************/

router.get('/all', async (req: Request, res: Response): Promise<Response> => {
    const data: IUser[] = await userDao.getAll();
    return res.status(OK).json(data);
});



/******************************************************************************
 *                       Add One - "POST /api/users/add"
 ******************************************************************************/

router.post('/add', async (req: IRequest, res: Response): Promise<Response> => {
    const { user } = req.body;
    if (!user) {
        return res.status(BAD_REQUEST).json({
            error: paramMissingError,
        });
    }
    const data: IUser = await userDao.add(user);
    return res.status(CREATED).json(data);
});



/******************************************************************************
 *                       Update - "PUT /api/users/update"
 ******************************************************************************/

router.put('/update', async (req: IRequest, res: Response): Promise<Response> => {
    const { user } = req.body;
    if (!user) {
        return res.status(BAD_REQUEST).json({
            error: paramMissingError,
        });
    }
    user.id = Number(user.id);
    const data: IUser = await userDao.update(user);
    return res.status(OK).json(data);
});



/******************************************************************************
 *                    Delete - "DELETE /api/users/delete/:id"
 ******************************************************************************/

router.delete('/delete/:id', async (req: IRequest, res: Response): Promise<Response> => {
    const { id } = req.params;
    const data: IUser = await userDao.delete(Number(id));
    return res.status(OK).json(data);
});



/******************************************************************************
 *                                     Export
 ******************************************************************************/

export default router;
