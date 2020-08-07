import {shallow} from "enzyme";
import Header from "../Header";
import React from "react";

describe("<Header/>", () => {
    it("take a snapshot", () => {
        const header = shallow(<Header />);
        expect(header).toMatchSnapshot();
    });
});
