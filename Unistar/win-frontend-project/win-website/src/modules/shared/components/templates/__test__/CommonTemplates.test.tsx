import "jest-enzyme";
import CommonTemplates from "../CommonTemplates";
import {shallow} from "enzyme";
import React from "react";

describe("<CommonTemplates />", (): void => {
    it("take a snapshot", (): void => {
        const wrapper = shallow(<CommonTemplates />);
        expect(wrapper).toMatchSnapshot();
    });
});
