import "jest-enzyme";
import Footer from "../Footer";
import {shallow} from "enzyme";
import React from "react";

describe("<Footer />", (): void => {
    it("take a snapshot", (): void => {
        const wrapper = shallow(<Footer />);
        expect(wrapper).toMatchSnapshot();
    });
});
