import {shallow} from "enzyme";
import AboutPage from "../AboutPage";
import React from "react";

describe("<AboutPage/>", () => {
    it("take a snapshot", () => {
        const wrapper = shallow(<AboutPage />);
        expect(wrapper).toMatchSnapshot();
    });
});
