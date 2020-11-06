import * as React from "react";

export type withReduxState = {

};

export type withReduxAction = {
    type: withReduxActionTypes,
    data: Object,
};

export enum withReduxActionTypes {
    Create,
    Read,
    Update,
    Delete,
}

export const initwithReduxState: withReduxState = {

};
