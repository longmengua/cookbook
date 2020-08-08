import React, {useState, useRef, useCallback, useEffect} from "react";

import Info from "modules/shared/components/atomic/Info";
import WinningInfo from "modules/shared/components/atomic/WinningInfo";
import NextIssueInfo from "modules/shared/components/atomic/NextIssueInfo";
import CDNHelper from "modules/shared/utils/CDNHelper";
import {GameWinningNumberAJAXResponse} from "type/api";

interface ComponentProps {
    lotteryName: string | undefined;
    lastIssue: GameWinningNumberAJAXResponse;
    logoUrl: string;
}
export default function LotteryInfoHeader(props: ComponentProps) {
    const [previosIssue, setPreviosIssue] = useState<string>("xxxxxxxxxx");
    const [winNumber, setNumber] = useState<string[] | null>();
    useEffect(() => {
        if (!props.lastIssue || !props.lastIssue.numero) {
            return;
        }
        setPreviosIssue(props.lastIssue.numero);
        setNumber(props.lastIssue.winningNumbers);
    }, [props.lastIssue]);

    return (
        <React.Fragment>
            <Info name={props.lotteryName} imagePath={props.lastIssue ? CDNHelper.CDNPath + props.logoUrl : ""} />
            <WinningInfo issue={previosIssue} numbers={winNumber || []} />
        </React.Fragment>
    );
}
