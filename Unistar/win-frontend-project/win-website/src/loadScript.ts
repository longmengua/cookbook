type Callback = (msg: any, script: HTMLScriptElement) => void;

function loadScript(
    src: string,
    opts: {
        async?: boolean;
        attrs?: any;
        charset?: string;
        text?: string;
        type?: string;
    },
    cb: Callback
) {
    const head = document.head || document.getElementsByTagName("head")[0];
    const script = document.createElement("script");

    if (typeof opts === "function") {
        cb = opts;
        opts = {};
    }
    const cbInit = () => {};
    opts = opts || {};
    cb = cb || cbInit;

    script.type = opts.type || "text/javascript";
    script.charset = opts.charset || "utf8";
    script.async = "async" in opts ? !!opts.async : true;
    script.src = src;

    if (opts.attrs) {
        setAttributes(script, opts.attrs);
    }

    if (opts.text) {
        script.text = "" + opts.text;
    }

    const onend = "onload" in script ? stdOnEnd : ieOnEnd;
    onend(script, cb);

    // some good legacy browsers (firefox) fail the 'in' detection above
    // so as a fallback we always set onload
    // old IE will ignore this and new IE will set onload
    if (!script.onload) {
        stdOnEnd(script, cb);
    }

    head.appendChild(script);
}

function setAttributes(script: HTMLScriptElement, attrs: any) {
    for (const attr of Object.keys(attrs)) {
        script.setAttribute(attr, attrs[attr]);
    }
}

function stdOnEnd(script: HTMLScriptElement, cb: Callback) {
    script.onload = function() {
        this.onerror = this.onload = null;
        cb(null, script);
    };
    script.onerror = function() {
        // this.onload = null here is necessary
        // because even IE9 works not like others
        this.onerror = this.onload = null;
        cb(new Error("Failed to load " + this.src), script);
    };
}

function ieOnEnd(script: any, cb: Callback) {
    script.onreadystatechange = function() {
        if (this.readyState !== "complete" && this.readyState !== "loaded") {
            return;
        }
        this.onreadystatechange = null;
        cb(null, script); // there is no way to catch loading errors in IE8
    };
}

export default loadScript;
