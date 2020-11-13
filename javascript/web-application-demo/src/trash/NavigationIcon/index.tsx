import React, {useEffect, useRef, useState} from "react";
import "./styles/style.sass";
import "./styles/day.sass";
import "./styles/night.sass";

type NavigationIconProps = {
    isActive?: boolean;
    className: string;
    name: string;
    click?: () => void;
    tipOnclick?: () => void;
    count?: number;
    msgTip?: string;
};
const NavigationIcon: React.FC<NavigationIconProps> = (props: NavigationIconProps) => {
    const target = useRef<HTMLDivElement>(null);
    const [show, setShow] = useState(false);
    useEffect(() => {
        setShow(props.msgTip != "");
    }, [props.msgTip]);
    return (
        <React.Fragment>
            <div
                ref={target}
                className="navigation-icon"
                key={props.className}
                onClick={() => props.click && props.click()}
                onMouseOver={() => {
                    setShow(true);
                }}
            >
                {!!props.count && props.count > 0 && <div className="news">{props.count}</div>}
                <input
                    name="nav-bar"
                    type="radio"
                    id={`footer-${props.className}`}
                    defaultChecked={props.isActive || false}
                    onClick={e => e.stopPropagation()}
                />
                <label htmlFor={`footer-${props.className}`} className={props.className} />
                <div className="text">{props.name}</div>
                {props.msgTip && props.msgTip != "" && (
                    <span
                        className="tooltipText"
                        onClick={e => {
                            props.tipOnclick && props.tipOnclick();
                            e.stopPropagation();
                        }}
                    >
                        {props.msgTip}
                    </span>
                )}
            </div>
            {/*FIXME: show*/}
            {/*{show && (*/}
            {/*    <Tooltip target={target} placement="top" show={show}>*/}
            {/*        <InputLintContent>{props.msgTip}</InputLintContent>*/}
            {/*    </Tooltip>*/}
            {/*)}*/}
        </React.Fragment>
    );
};

export default NavigationIcon;
