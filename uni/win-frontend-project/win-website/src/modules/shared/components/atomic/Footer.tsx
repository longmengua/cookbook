import React from "react";
// import "../../styles/layout/_footer.scss";
function Footer(): React.FunctionComponentElement<{}> {
    return (
        <div className="footer">
            <div className="container">
                <div className="logo">
                    <img src={require("../../../../asset/images/logo.png")} />
                </div>
                <div className="copyright">Copyright @奖源8网 2019 All Right Reserved.</div>
                <div className="help-item">
                    <ul>
                        <li>
                            <div className="help-icon01">
                                <span className="help-tip"> QQ : 213759986</span>
                            </div>
                        </li>
                        <li>
                            <div className="help-icon02">
                                <span className="help-tip">skype : +639459734806</span>
                            </div>
                        </li>
                        <li>
                            <div className="help-icon03">
                                <span className="help-tip">telegram : +639459734820</span>
                            </div>
                        </li>
                        <li>
                            <div className="help-icon04">
                                <span className="help-tip">gmail : jy8web@gmail.com</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    );
}

export default Footer;
