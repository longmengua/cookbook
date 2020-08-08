// webpack.config.js
const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const { HotModuleReplacementPlugin } = require('webpack')

module.exports = {
    mode: "production",
    entry: ['./src/index.jsx','./src/index.css','./src/index2.css',], // .js after index is optional
    output: {
        path: path.join(__dirname, 'dist'),
        filename: 'bundle.js'
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: './src/index.html'
        }),
        new HotModuleReplacementPlugin(),

    ],
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader'],
            },
            {
                test: /\.(png|jpe?g|gif)/,
                use:['file-loader']
            },
            {
                test: /\.(js|jsx)$/,
                exclude: /node_modules/,
                use: [{
                    loader: 'babel-loader',
                    options: {
                        // cacheDirectory: 'cache-dir-path',
                        presets: ["@babel/preset-react"],
                    }
                }, "eslint-loader"]
            }
        ]
    },
    devServer:{
        port: 1234,
        hot: true,
    }
}