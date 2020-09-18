const webpack = require("webpack")
const HtmlWebpackPlugin = require("html-webpack-plugin")
const path = require("path")
// const env = require("./env")
const root = path.resolve("")

const devServer = {
    contentBase: path.join("public"),
    compress: true,
    port: 1234,
    hot: true,
    index: 'index.html',
}

const resolve = {
    extensions: [".js"],
    modules: ["node_modules"],
}

const entry = {
    index: "./src/index.js",
}

const output = {
    path: path.resolve("static"),
    filename: "[hash:8].js",
}

const plugins = [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
        template: 'index.html'
    })
]

const _module = {
    rules: [
        {
            test: /\.(js|jsx)$/,
            exclude: /node_modules/,
            include: [
                path.resolve(root,"src")
            ],
            use: [{
                loader: 'babel-loader',
                // options: {
                //     presets: ['@babel/preset-react'],
                // }
            }]
        },
        // {
        //     test: /\.(js|jsx|ts|tsx)$/,
        //     include: env.src,
        //     loader: "ts-loader",
        //     options: {
        //         configFile: env.tsConfig,
        //         transpileOnly: true,
        //         getCustomTransformers: () => ({
        //             before: [TSImportPlugin({libraryName: "antd", libraryDirectory: "es", style: true})],
        //         }),
        //     },
        // },
        // // NOTICE: 待釐清css preprocess
        // {
        //     test: /\.(sass)$/,
        //     use: [
        //         "style-loader",
        //         "css-loader",
        //         'sass-loader',
        //     ],
        // },
        // {
        //     test: /\.(css|less)$/,
        //     use: [
        //         MiniCSSExtractPlugin.loader,
        //         {
        //             loader: "css-loader",
        //             options: {
        //                 sourceMap: false,
        //                 importLoaders: 2,
        //             },
        //         },
        //         {
        //             loader: "postcss-loader",
        //             options: {
        //                 sourceMap: false,
        //                 plugins: () => [autoprefixer],
        //             },
        //         },
        //         {
        //             loader: "less-loader",
        //             options: {
        //                 javascriptEnabled: true,
        //                 sourceMap: false,
        //             },
        //         },
        //     ],
        // },
        // {
        //     test: /\.(png|jpe?g|gif)$/,
        //     loader: "url-loader",
        //     query: {
        //         limit: 1024,
        //         name: "static/img/[name].[hash:8].[ext]",
        //     },
        // },
        // {
        //     test: /\.(woff|woff2|eot|ttf|otf)$/,
        //     loader: "file-loader",
        //     options: {
        //         name: "static/font/[name].[hash:8].[ext]",
        //     },
        // },
        // {
        //     test: /\.ico$/,
        //     loader: "file-loader",
        //     options: {
        //         name: "static/icon/[name].[hash:8].[ext]",
        //     },
        // },
    ],
}

const config = {
    mode: 'none',
    module: _module,
    entry,
    output,
    devServer,
    resolve,
    plugins,
}

module.exports = config