import React from "react";
import {Carousel} from "react-responsive-carousel";
import {Link} from "react-router-dom";
import "react-responsive-carousel/lib/styles/carousel.min.css";
// import "../../../styles/components/_banner.scss";

function Banner(): React.FunctionComponentElement<{}> {
    // FIXME: 待串 API
    const showArrows = ["banner01.jpg", "banner02.jpg"].length > 1;
    return (
        <div
            className="banner"
            style={{
                cursor: "pointer",
            }}
        >
            <Carousel
                showArrows={showArrows}
                useKeyboardArrows={false}
                autoPlay
                infiniteLoop
                interval={5000}
                showThumbs={false}
                onClickItem={index => {
                    // FIXME: API
                    const lottery = ["/lotteryInfo/TB2F", "/lotteryInfo/CQSSC"];
                    window.open(lottery[index], "_self");
                }}
            >
                <div>
                    <Link to="/lotteryInfo/TB2F">
                        <img src={require("../../../asset/images/banner01.jpg")} />
                    </Link>
                </div>

                <div>
                    <Link to="/lotteryInfo/TB2F">
                        <img src={require("../../../asset/images/banner02.jpg")} />
                    </Link>
                </div>
            </Carousel>
        </div>
    );
}

export default Banner;
