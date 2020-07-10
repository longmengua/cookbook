const path = require('path');
const webpack = require('webpack');
const publicPath = '/dist/build/';
const HtmlWebpackPlugin = require('html-webpack-plugin');

const rootPath = path.resolve(__dirname, "");

module.exports = {
    mode: 'development',
    entry: {'index': './index.jsx'},
    devtool: 'cheap-module-source-map',
    plugins: [
        // Simplifies creation of HTML files to serve your webpack bundles.
        // This is especially useful for webpack bundles that include a hash in the filename which changes every compilation.
        // You can either let the plugin generate an HTML file for you,
        // supply your own template using lodash templates or use your own loader.
        new HtmlWebpackPlugin({
            template: rootPath + '/index.html',
            filename: 'index.html',
        }),
        //Auto replacement of page when i save some file, even css
        new webpack.HotModuleReplacementPlugin()
    ],
    output: {
        path: path.join(__dirname, publicPath),
        filename: '[name].bundle.js',
        publicPath: publicPath,
        sourceMapFilename: '[name].map',
    },
    devServer: {
        port: 3000,
        host: 'localhost',
        //Be possible go back pressing the "back" button at chrome
        // historyApiFallback: true,
        // noInfo: false,
        // stats: 'minimal',
        // publicPath: publicPath,
        // contentBase: path.join(__dirname, publicPath),
        //hotmodulereplacementeplugin
        hot: true,
        http2: true,
        // https: true,
        index: 'index.html',
        // inline: false,
        open: true,
    },
    module: {
        rules: [
            {
                test: /\.css$/, use: ['style-loader', 'css-loader'],
                include: /flexboxgrid/
                //Follow instructions at https://github.com/roylee0704/react-flexbox-grid
            },
            {
                test: /\.(png|svg|jpg|gif)$/,
                use: ['file-loader']
            },
            {
                test: /\.js|.jsx?$/,
                exclude: /(node_modules)/,
                use: {
                    loader: '@playlyfe/babel-loader',
                    options: {
                        // cacheDirectory: 'cache-dir-path'
                    }
                }
            }]
    },
}
