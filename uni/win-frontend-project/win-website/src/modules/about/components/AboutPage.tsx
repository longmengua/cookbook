import React from "react";
import CommonTemplates from "../../shared/components/templates/CommonTemplates";

export default function AboutPage() {
    return (
        <CommonTemplates>
            <div className="about-banner">
                <img src={require("../../../asset/images/about-banner.jpg")} />
            </div>

            <div className="about-content">
                <img src={require("../../../asset/images/about_item.jpg")} />
            </div>
        </CommonTemplates>
    );
}
