import * as React from "react";
import {PathProps} from "./Path/interface";

export interface WithRouterComponents {
    Path: React.ComponentType<PathProps>;
}

export type WithRouterProps = {
    children?: React.ReactNode,
};

export type WithRouterState = {

};

export const initWithRouterState: WithRouterState = {

};
