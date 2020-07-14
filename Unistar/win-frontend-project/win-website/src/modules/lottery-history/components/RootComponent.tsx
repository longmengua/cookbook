import React, {Component} from "react";
// import LotteryHistoryPage from '../LotteryHistoryPage';
import LotteryHistoryPage from "./HistoryPage";
import {DispatchProp, connect} from "react-redux";
import {RootState} from "type/appState";

import {ModuleState} from "modules/lottery-history/types";

import {RouteComponentProps} from "react-router";
import {actions as lotteryHistory} from "../";
interface ContainerProps {}

type ComponentProps = ContainerProps & ModuleState & DispatchProp & RouteComponentProps;

class LotteryHistoryContainer extends Component<ComponentProps> {
    public componentDidMount() {
        this.props.dispatch(lotteryHistory.loadCurrentGameSetting());
        this.props.dispatch(lotteryHistory.loadHistory());
    }
    public render() {
        return <LotteryHistoryPage gameSetting={this.props.currentIssue} history={this.props.historyList} />;
    }
}
const mapStateToProps = (state: RootState): ModuleState => {
    return {
        historyList: state.app.lotteryHistoryModule.historyList,
        currentIssue: state.app.lotteryHistoryModule.currentIssue,
    };
};
export default connect(mapStateToProps)(LotteryHistoryContainer);
