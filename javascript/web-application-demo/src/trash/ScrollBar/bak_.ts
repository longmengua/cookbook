import HTMLElement from "typescript";

type scrollBarWrapperProps = {
	refresh: () => void;
	arrow_scroll: () => void;
	mousedown: () => void;
	onmousemove: () => void;
	onmouseup: () => void;
	wrapperHeight: number;
	content: HTMLElement;
}

type scrollBarWrapperState = {

}

const initScrollBarWrapperState: scrollBarWrapperState = {

};

const scrollBarWrapper = (props: scrollBarWrapperProps) => {
	const state: scrollBarWrapperState = JSON.parse(JSON.stringify(initScrollBarWrapperState));

	props.content.clientHeight;
};

export default scrollBarWrapper;