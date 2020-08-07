import React from "react";
import {connect, DispatchProp} from "react-redux";
import {RouteComponentProps} from "react-router";
import LotteryInfoPage from "./LotteryInfoPage";
import {ModuleState} from "modules/lottery-info/types";
import {RootState} from "type/appState";
import {actions as lotteryInfoAction} from "../";

type Props = RouteComponentProps & DispatchProp & ModuleState;

class LotteryInfoRootComponent extends React.Component<Props> {
    constructor(props: Props) {
        super(props);
        this.state = {
            currentIssue: null,
        };
    }
    public componentDidMount(): void {
        // console.info("[LotteryInfoRootComponent] componentDidMount", this.props);
        this.props.dispatch(lotteryInfoAction.loadHistory());
    }
    public componentDidUpdate() {
        // console.info("[LotteryInfoRootComponent] componentDidUpdate", this.props);
    }

    public render(): JSX.Element {
        return <LotteryInfoPage gameSetting={this.props.currentIssue} history={this.props.historyList} />;
    }
}

const mapStateToProps = (state: RootState): ModuleState => {
    // const gameCode = state.router.location.pathname.split("/")[2];
    const gameCode = location.pathname.split("/")[2];
    const gameSettingArray = state.app.main.gameSetting && state.app.main.gameSetting.filter(setting => setting.gameCode === gameCode);
    const gameSetting = gameSettingArray && gameSettingArray[0];
    const currentIssue = gameSetting || state.app.lotteryInfoModule.currentIssue;

    return {
        historyList: state.app.lotteryInfoModule.historyList,
        currentIssue,
    };
};

export default connect(mapStateToProps)(LotteryInfoRootComponent);
