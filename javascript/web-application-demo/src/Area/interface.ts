import * as React from "react";

export type AreaProps = {
    children?: React.ReactNode,
    title?: string;
};

export type AreaState = {
    isExpand: boolean
};

export const initAreaState: AreaState = {
	isExpand: false
};
