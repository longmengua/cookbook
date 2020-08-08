const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const rootPath = path.resolve(__dirname, "src");

const webpackConfig = {
    mode: 'development',
    entry: {'index': path.resolve(rootPath, "index.jsx")},
    devtool: 'cheap-module-source-map',
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new HtmlWebpackPlugin({ template: path.resolve(rootPath, 'index.html') }),
    ],
    devServer: {
        port: 1203,
        hot: true,
    },
    module: {
        rules: [
            {
                test: /\.js|.jsx?$/,
                exclude: /(node_modules)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        cacheDirectory: 'cache-dir-path',
                        presets: ["@babel/preset-react"],
                    }
                }
            },
        ],
    },
}
module.exports = webpackConfig;
