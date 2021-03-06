import * as React from "react";

export type ScrollBarProps = {
    children?: React.ReactNode,
};

export type ScrollBarState = {
    parentHeight: number;
    childHeight: number;
    scrollY: number;
    scrollerHeight: number;
};

export const initScrollBarState: ScrollBarState = {
	parentHeight  : 0,
	childHeight   : 0,
	scrollY       : 0,
	scrollerHeight: 0
};
