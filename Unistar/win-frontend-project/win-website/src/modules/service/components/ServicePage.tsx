import React from "react";
import CommonTemplates from "../../shared/components/templates/CommonTemplates";

export default function ServicePage() {
    return (
        <CommonTemplates>
            <div className="sub-bg">
                <div className="container">
                    <div className="lottery-list-wrapper">
                        <div className="lottery-award-content">
                            <h3>服务项目说明</h3>
                            <div className="service-info-menu">
                                <ul>
                                    <li className="active">
                                        <div className="service01" />
                                        <h3>即时开奖</h3>
                                    </li>
                                    <li>
                                        <div className="service02" />
                                        <h3>开奖记录</h3>
                                    </li>
                                    <li>
                                        <div className="service03" />
                                        <h3>权威奖源</h3>
                                    </li>
                                    <li>
                                        <div className="service04" />
                                        <h3>奖源接口</h3>
                                    </li>
                                    <li>
                                        <div className="service05" />
                                        <h3>接口调用</h3>
                                    </li>
                                </ul>
                            </div>
                            <div className="service-info-content">
                                <div className="text-content">
                                    <p>奖源8网为彩票行业客户提供即时、安全、稳定的彩票开奖服务，以及全面的历史数据查询与推送服务。官方奖源，公信可靠。涵盖重庆时时彩（欢乐生肖）、上海11选5、淘宝两分彩等在内国内外各大热门官方彩种，高响应无延迟，安全防劫持，权威可靠！</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </CommonTemplates>
    );
}
