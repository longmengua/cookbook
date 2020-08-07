import React, {Suspense} from "react";
import {Route, Switch, BrowserRouter} from "react-router-dom";
import {async} from "core-fe";
// import { Layout } from "antd";
import ScrollToTop from "../../shared/components/ScrollToTop";

import "../../../asset/styles/all.scss";
import {connect, DispatchProp} from "react-redux";

// import "presentation/styles/all.scss"
// import NotFoundPage from "presentation/pages/NotFound";;

// Pages
const HomePage = async(() => import(/* webpackChunkName: "HomePage" */ "modules/home"), "HomePageComponent");
const LotteryListPage = async(() => import(/* webpackChunkName: "LotteryListPage" */ "modules/lottery-list"), "LotteryListPageComponent");
const LotteryInfoPage = async(() => import(/* webpackChunkName: "LotteryInfoPage" */ "modules/lottery-info"), "LotteryInfoPageComponent");
const LotteryHistoryPage = async(() => import(/* webpackChunkName: "LotteryHistoryPage" */ "modules/lottery-history"), "LotteryHistoryComponent");
const ServicePage = async(() => import(/* webpackChunkName: "ServicePage" */ "modules/service"), "ServicePageComponent");
const AboutPage = async(() => import(/* webpackChunkName: "AboutPage" */ "modules/about"), "AboutPageComponent");

// React.lazy
// const LotteryListPage = React.lazy(() => import(/* webpackChunkName: "LotteryListPage" */"presentation/pages/lotteryList/LotteryListPage"));
// const LotteryHistoryPage = React.lazy(() => import(/* webpackChunkName: "LotteryHistoryPage "*/"presentation/pages/lotteryHistory/LotteryHistoryPage"));
// const LotteryInfoPage = React.lazy(() => import(/* webpackChunkName: "LotteryInfoPage" */"presentation/pages/lotteryInfo/LotteryInfoPage"));

import {actions} from "../";

type Props = DispatchProp;

class ApplicationRouter extends React.Component<Props> {
    public componentDidMount() {
        // console.info("ApplicationRouter - componentDidMount", this.props);
        this.props.dispatch(actions.loadGameSettings());
    }
    public render(): JSX.Element {
        return (
            <Suspense fallback={<div>Loading...</div>}>
                <BrowserRouter>
                    <ScrollToTop>
                        <Switch>
                            <Route exact path="/" component={HomePage} />
                            {/* <Route
                            path="/"
                            exact
                            render={(...renderProps) => (
                                <HomePage {...renderProps} />
                            )}
                        /> */}
                            <Route exact path="/lotteryList" component={LotteryListPage} />
                            <Route exact path="/lotteryInfo/:gameCode" component={LotteryInfoPage} />
                            <Route exact path="/lotteryHistory/:gameCode" component={LotteryHistoryPage} />
                            <Route exact path="/service" component={ServicePage} />
                            <Route exact path="/about" component={AboutPage} />
                            {/* <Route exact component={NotFoundPage} /> */}
                            <Route exact component={HomePage} />
                        </Switch>
                    </ScrollToTop>
                </BrowserRouter>
            </Suspense>
        );
    }
}

// export default ApplicationRouter;
export default connect()(ApplicationRouter);
