import React from "react";
// import "../../../styles/components/_services.scss";
function Service(): React.FunctionComponentElement<{}> {
    return (
        <div className="service">
            <div className="service-item container">
                <h2>服务项目</h2>
                <ul className="service-info">
                    <li>
                        <div>
                            <img src={require("../../../asset/images/service01.png")} />
                        </div>
                        <h3>即时开奖</h3>
                        <div className="info-text">瞬间秒开，稳定快速</div>
                        {/* <div className="more-btn">查看详情</div> */}
                    </li>
                    <li>
                        <div>
                            <img src={require("../../../asset/images/service02.png")} />
                        </div>
                        <h3>开奖记录</h3>
                        <div className="info-text">历史数据，随时查阅</div>
                        {/* <div className="more-btn">查看详情</div> */}
                    </li>
                    <li>
                        <div>
                            <img src={require("../../../asset/images/service03.png")} />
                        </div>
                        <h3>权威奖源</h3>
                        <div className="info-text">官方合作，公信可靠</div>
                        {/* <div className="more-btn">查看详情</div> */}
                    </li>
                    <li>
                        <div>
                            <img src={require("../../../asset/images/service04.png")} />
                        </div>
                        <h3>奖源接口</h3>
                        <div className="info-text">API调用，一键接入</div>
                        {/* <div className="more-btn">查看详情</div> */}
                    </li>
                    <li>
                        <div>
                            <img src={require("../../../asset/images/service04.png")} />
                        </div>
                        <h3>数据安全</h3>
                        <div className="info-text">专业运维，有效防劫持</div>
                        {/* <div className="more-btn">查看详情</div> */}
                    </li>
                </ul>
            </div>
        </div>
    );
}

export default Service;
