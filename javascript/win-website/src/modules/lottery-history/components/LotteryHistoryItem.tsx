import React, {useMemo} from "react";
import classNames from "classnames";

interface ItemProps {
    date: string;
    number: string[] | null;
    issueNumber: string;
    originalNumber: string | null;
    showOriginal: boolean | undefined;
}

export default function LotteryHistoryItem(props: ItemProps) {
    // NOTICE: become more slowly
    const memoizedComponents = useMemo(() => {
        const components: JSX.Element[] = [];
        // default
        if (props.number && props.number.length === 0) {
            components.push(
                <span key={1} style={{visibility: "hidden"}}>
                    x
                </span>
            );
        } else if (props.number && props.number.length > 0) {
            props.number.forEach((winNumber, index) => {
                // NOTE: add className(blue-ball) for blue color ball
                components.push(<span key={index}>{winNumber}</span>);
            });
        }
        return components;
    }, [props.number]);

    // const memoizedComponents: JSX.Element[] = [];
    // if (props.number.length == 0) {
    //     memoizedComponents.push(<span style={{ visibility: "hidden" }}>x</span>)
    // } else {
    //     props.number.forEach((number, index) => {
    //         memoizedComponents.push((
    //             <span key={index}>{number}</span>
    //         ))
    //     })
    // }
    return (
        // <li className={classNames({"two-row": props.number && props.number.length === 20})}>
        <li>
            <div>{props.date}</div>
            <div>{props.issueNumber}</div>
            <div className="award-num">{memoizedComponents}</div>
            {/* 使否顯示數據獎號 */}
            {props.showOriginal && <div>{props.originalNumber}</div>}
        </li>
    );
}
