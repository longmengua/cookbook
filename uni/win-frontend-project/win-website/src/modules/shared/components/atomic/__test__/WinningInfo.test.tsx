import {shallow} from "enzyme";
import WinningInfo from "../WinningInfo";
import React from "react";

describe("<WinningInfo/>", () => {
    it("take a snapshot", () => {
        const winningInfo = shallow(<WinningInfo issue="20190726-23" numbers={["1", "2", "3", "4"]} />);
        expect(winningInfo).toMatchSnapshot();
    });
});
