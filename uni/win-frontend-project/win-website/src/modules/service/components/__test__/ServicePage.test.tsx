import {shallow} from "enzyme";
import React from "react";
import ServicePage from "../ServicePage";

describe("<ServicePage>", () => {
    it("take a snapshot", () => {
        const component = shallow(<ServicePage />);
        expect(component).toMatchSnapshot();
    });
});
