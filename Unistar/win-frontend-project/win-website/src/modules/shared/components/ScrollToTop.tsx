import {Component} from "react";
import {withRouter, RouteComponentProps} from "react-router-dom";

class ScrollToTop extends Component<RouteComponentProps> {
    public componentDidUpdate(prevProps: RouteComponentProps) {
        if (!this.props.location || !prevProps || !prevProps.location) {
            return;
        }

        if (this.props.location.pathname !== prevProps.location.pathname) {
            window.scrollTo(0, 0);
        }
    }
    public render() {
        return this.props.children;
    }
}

export default withRouter(ScrollToTop);
