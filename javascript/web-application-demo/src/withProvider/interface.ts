import * as React from "react";

export type withProviderProps = {
    children?: React.ReactNode,
};

export type withProviderState = {

};

export type withProviderAction = {
    type: withProviderActionTypes,
    data: Object,
};

export enum withProviderActionTypes {
    Create,
    Read,
    Update,
    Delete,
}

export const initwithProviderState: withProviderState = {

};
