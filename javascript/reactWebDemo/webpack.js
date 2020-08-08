const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const rootPath = path.resolve(__dirname, "src");
const publicPath = path.join(__dirname, '/dist/');

const webpackConfig = {
    mode: 'production',
    entry: {'index': path.resolve(rootPath, "index.jsx")},
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
        path: publicPath,
        filename: '[hash].js',
        publicPath: "",
        sourceMapFilename: '[hash].map',
    },
    devServer: {
        port: 1203,
        hot: true,
        contentBase: path.join(__dirname, publicPath),
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
                    loader: 'babel-loader',
                    options: {
                        // cacheDirectory: 'cache-dir-path',
                        presets: ["@babel/preset-react"],
                    }
                }
            },
        ]
,    },
}
module.exports = webpackConfig;
