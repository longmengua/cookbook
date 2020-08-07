import React from "react";
import {DispatchProp, connect} from "react-redux";
import {ModuleState} from "modules/home/types";
import {RootState} from "type/appState";
import Banner from "./Banner";
import Lottery from "./Lottery";
import Service from "./Service";

import lotteryList from "./lotteryList";

import CommonTemplates from "modules/shared/components/templates/CommonTemplates";

type ContainerProps = DispatchProp & ModuleState;
class HomePageContainer extends React.Component<ContainerProps> {
    public render(): JSX.Element {
        return (
            <CommonTemplates>
                <Banner />
                <Lottery lotteryList={lotteryList} />
                <Service />
            </CommonTemplates>
        );
    }
}
const mapStateToProps = (state: RootState): ModuleState => {
    return {
        lotteryList: state.app.homeModule.lotteryList,
    };
};
export default connect(mapStateToProps)(HomePageContainer);
