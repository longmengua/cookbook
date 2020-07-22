const config = {
    mode: "development",
    entry: "index.tsx",
    output:{
        filename: "build/[name].js",
        publicPath: "/",
    },
    resolve:{
        extensions:[".ts", ".tsx", ".js", ".jsx"],

    }
}

module.exports = config;
