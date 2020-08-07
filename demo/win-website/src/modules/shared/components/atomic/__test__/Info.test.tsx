import {shallow} from "enzyme";
import Info from "../Info";
import React from "react";

describe("<Info/>", () => {
    it("take a snapshot", () => {
        const info = shallow(<Info imagePath={require("presentation/asset/images/lottery05.png")} name={"淘宝2分彩"} />);
        expect(info).toMatchSnapshot();
    });
});
