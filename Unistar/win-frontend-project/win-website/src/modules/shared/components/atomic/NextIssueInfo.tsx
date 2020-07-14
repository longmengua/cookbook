import React from "react";

interface ComponentProps {
    issue: string;
    time: string;
}

export default function NextIssueInfo(props: ComponentProps) {
    return (
        <div className="lottery-time">
            <div className="time-issue">
                距離<label className="orange-text">{props.issue}</label> 期开奖剩餘時間
            </div>
            <div className="countdown">
                <span>{props.time[0]}</span>
                <span>{props.time[1]}</span>
                <span>{props.time[2]}</span>
                <span className="sepl">:</span>
                <span>{props.time[3]}</span>
                <span>{props.time[4]}</span>
                <span className="sepl">:</span>
                <span>{props.time[5]}</span>
                <span>{props.time[6]}</span>
            </div>
        </div>
    );
}
