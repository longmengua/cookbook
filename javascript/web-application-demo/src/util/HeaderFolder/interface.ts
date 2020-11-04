import * as React from "react";

export type HeaderFolderProps = {
    children?: React.ReactNode,
    imgPath?: string,
    isExpanded?: boolean,
};

export type HeaderFolderState = {
    isExpanded?: boolean,
};

export const initHeaderFolderState: HeaderFolderState = {
	isExpanded: false,
};
