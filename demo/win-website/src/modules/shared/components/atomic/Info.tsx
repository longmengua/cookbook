import React from "react";

interface Props {
    // 保留彩种名称长度为10
    name: string | undefined;
    imagePath: string;
}
export default function Info(props: Props) {
    return (
        <div className="lottery-game">
            <h3>{props.name}</h3>
            <div>
                <img src={props.imagePath} />
            </div>
        </div>
    );
}
