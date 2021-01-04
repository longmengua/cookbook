import { Router } from 'express';
import UserRouter from './Users/Users';
//Status code enum
enum MsgCode {
    successful = "successful",
    error = "error",
}
//Response interface
interface ResponseEntity {
    msgCode: MsgCode,
    data: any,
}

// Init router and path
const router = Router();

// Add sub-routes
router.use('/users', UserRouter);

// Export the base-router
export default router;
export { ResponseEntity, MsgCode };
