import Header from "../atomic/Header";
import Footer from "../atomic/Footer";
import React from "react";

class CommonTemplates extends React.Component {
    public render(): JSX.Element {
        return (
            <>
                <Header />
                {this.props.children}
                <Footer />
            </>
        );
    }
}
export default CommonTemplates;
