import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import Input from "components/Input";
import Number from "utils/Number";

const removeComma = num => `${num}`.replace(/[^0-9.-]+/g, "");

const format = (num, digit) => {
    const digitLimit = digit ? `{1,${digit}}` : "+";
    const regExp = new RegExp(`\\.\\d${digitLimit}`);
    let digitOfNum = `${num}`.match(regExp);
    let amount = +removeComma(num);
    amount = isNaN(amount) ? 0 : amount;

    if (/\.$/.test(`${num}`)) {
        return `${Number.f(amount, { digit: 0 })}.`;
    } else if (digitOfNum) {
        return `${Number.f(amount, { digit: digitOfNum[0].length - 1 })}`;
    } else {
        return Number.f(amount, { digit: 0 });
    }
};

const Currency = React.forwardRef((props, ref) => {
    // 為保留小數點，amount 須以字串形式保存
    const [amount, setAmount] = useState(`${props.defaultAmount}` || `${props.amount}`);

    const handleChange = e => {
        // 空值預設 0
        if (e.target.value === "") {
            props.onChange(
                {
                    target: {
                        ...e.target,
                        value: "0",
                    },
                },
                "0"
            );
            setAmount("0");
            return;
        }

        // 非數值不更新
        if (!/^[0-9.,-]+$/.test(e.target.value)) return;
        if (props.filter && !props.filter.test(+removeComma(e.target.value))) return;

        const formatAmount = format(e.target.value, props.digit);
        props.onChange(
            {
                target: {
                    ...e.target,
                    // 以字串形式才能保存小數點；須先格式化為數值，例如：01 格式化為 1
                    value: +removeComma(formatAmount),
                },
            },
            formatAmount
        );
        setAmount(formatAmount);
    };

    useEffect(() => {
        // 空值預設 0
        if (`${props.amount}` === "") {
            setAmount("0");
            return;
        }

        // 非數值不更新
        if (!/^[0-9.,-]+$/.test(`${props.amount}`)) return;

        const formatAmount = format(props.amount, props.digit);
        setAmount(formatAmount);
    }, [props.amount, props.digit]);
    return (
        <span className="input-affix-wrapper prefix">
            {props.showIcon && <span className="input-prefix">￥</span>}
            <Input type="text" value={amount} onChange={handleChange} onKeyDown={props.onKeyDown} ref={ref} />
        </span>
    );
});

Currency.propTypes = {
    showIcon: PropTypes.bool,
    filter: PropTypes.object,
    defaultAmount: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
    amount: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
    digit: PropTypes.oneOfType([PropTypes.number, PropTypes.oneOf([null])]),
    onChange: PropTypes.func,
    onKeyDown: PropTypes.func,
};

Currency.defaultProps = {
    showIcon: true,
    filter: "",
    defaultAmount: "0",
    amount: "0",
    digit: null,
    onChange(originAmount, formatAmount) {
        console.log(originAmount, formatAmount);
    },
    onKeyDown() {},
};

export default Currency;
