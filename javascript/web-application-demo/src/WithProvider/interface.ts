import * as React from "react";

export type WithProviderProps = {
    children?: React.ReactNode,
};

export type WithProviderState = {

};

export type WithProviderAction = {
    type: WithProviderActionTypes,
    data: Object,
};

export enum WithProviderActionTypes {
    Create,
    Read,
    Update,
    Delete,
}

export const initWithProviderState: WithProviderState = {

};
