import React from "react";
import {connect, DispatchProp} from "react-redux";
import LotteryListPage from "./LotteryListPage";

import {actions as lotteryListActions} from "modules/lottery-list";
import {RootState} from "type/appState";
import {ModuleState} from "modules/lottery-list/types";
import {actions as lotteryInfoAction} from "modules/lottery-info";

type ContainerProps = DispatchProp & ModuleState;
class LotteryListRootComponent extends React.Component<ContainerProps> {
    public componentDidMount(): void {
        // console.info("[LotteryListRootComponent] componentDidMount", this.props)
        this.props.dispatch(lotteryListActions.loadLotteryCategory());
    }
    public componentDidUpdate(): void {
        // console.info("[LotteryListRootComponent] componentDidUpdate", this.props)
    }
    public render(): JSX.Element {
        // console.info("[LotteryListRootComponent] render.categoryList", this.props.categoryList)
        return <LotteryListPage gameCategories={this.props.categoryList} />;
    }
}

const mapStateToProps = (state: RootState): ModuleState => {
    // console.info("[LotteryListRootComponent] mapStateToProps", state)
    return {
        categoryList: state.app.lotteryListModule.categoryList,
    };
};
export default connect(mapStateToProps)(LotteryListRootComponent);
