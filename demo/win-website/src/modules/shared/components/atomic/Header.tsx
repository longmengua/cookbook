import React from "react";
// import "../../styles/layout/_header.scss"
import {withRouter, Link} from "react-router-dom";
import {RouteComponentProps} from "react-router";
import classNames from "classnames";
import {GACommon} from "modules/shared/utils/GoogleAnalyticsHelper";

type HeaderProps = React.FunctionComponent & RouteComponentProps;

const Header = (props: HeaderProps): React.FunctionComponentElement<HeaderProps> => {
    const isActive = (pathname: string): boolean => {
        if (props.location.pathname === pathname) {
            return true;
        } else {
            return false;
        }
    };
    const pushLocation = (pathname: string): void => {
        props.history.push(pathname);
    };

    return (
        <div className="header">
            <div className="container">
                <div className="logo">
                    <Link to="/">
                        <img src={require("../../../../asset/images/logo.png")} />
                    </Link>
                </div>
                {/* 品牌标语，14个字内 */}
                <div className="slogan">奖源公信力第一品牌</div>
                <div className="nav">
                    <ul>
                        <li
                            className={classNames({active: isActive("/")})}
                            onClick={(): void => {
                                pushLocation("/");
                            }}
                        >
                            首页
                        </li>
                        <li
                            className={classNames({active: isActive("/lotteryList")})}
                            onClick={(): void => {
                                GACommon.getInstance().pageviewTriggerLotteryList();
                                pushLocation("/lotteryList");
                            }}
                        >
                            彩种列表
                        </li>
                        <li
                            className={classNames({active: isActive("/service")})}
                            onClick={(): void => {
                                pushLocation("/service");
                            }}
                        >
                            服务项目说明
                        </li>
                        <li
                            className={classNames({active: isActive("/about")})}
                            onClick={(): void => {
                                pushLocation("/about");
                            }}
                        >
                            关于我们
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    );
};
export default withRouter(Header);
