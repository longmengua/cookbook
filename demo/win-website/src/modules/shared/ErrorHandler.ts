// import { message } from "antd";
import {ErrorListener, Exception} from "core-fe";
import {SagaIterator} from "redux-saga";

export class ErrorHandler implements ErrorListener {
    public *onError(exception: Exception): SagaIterator {
        // message.error(exception.message, 5);
        console.error(exception.message, 5);
    }
}
