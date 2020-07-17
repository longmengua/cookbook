import {shallow} from "enzyme";
import React from "react";
import NextIssueInfo from "../NextIssueInfo";

describe("<NextIssueInfo/>", () => {
    it("take a snapshot", () => {
        const nextIssueInfo = shallow(<NextIssueInfo issue="20190726-23" time="001234" />);
        expect(nextIssueInfo).toMatchSnapshot();
    });
});
