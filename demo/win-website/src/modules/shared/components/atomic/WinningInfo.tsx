import React, {useMemo} from "react";

interface Props {
    issue: string;
    numbers: string[];
}

export default function WinningInfo(props: Props) {
    const numbers: React.ReactElement[] = useMemo(() => {
        const components: JSX.Element[] = [];
        const hasData = props.numbers;
        if (hasData) {
            props.numbers.forEach((winNumber, index) => {
                components.push(
                    <li key={index} className="red-ball">
                        {winNumber}
                    </li>
                );
            });
        }
        return components;
    }, [props.numbers]);

    return (
        <div className="lottery-number">
            <div className="open-issue">
                第<label className="orange-text">{props.issue}</label>期开奖号码
            </div>
            <div className="lottery-balls">
                <ul>{numbers}</ul>
            </div>
        </div>
    );
}
