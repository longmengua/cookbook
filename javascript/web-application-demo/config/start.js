const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");
// const env = require("./env")
const root = path.resolve("");

const devServer = {
	contentBase: path.join("public"),
	compress: true,
	port: 1234,
	hot: true,
	index: 'index.html',
};

const resolve = {
	extensions: [ '.tsx', '.ts', '.js' ],
	modules: ["node_modules"],
};

const entry = {
	index: "./src/index.js",
};

const output = {
	path: path.resolve("static"),
	filename: "[hash:8].js",
};

const plugins = [
	new webpack.HotModuleReplacementPlugin(),
	new HtmlWebpackPlugin({
		template: 'index.html'
	})
];

const _module = {
	rules: [
		/**
   * @Note babel parsing jsx
   * */
		// {
		// 	test: /\.jsx?$/,
		// 	exclude: /node_modules/,
		// 	include: [
		// 		path.resolve(root,"src")
		// 	],
		// 	use: [{
		// 		loader: 'babel-loader',
		// 		/**
       // * @Note this configuration is react
       // * */
		// 		// options: {
		// 		//     presets: ['@babel/preset-react'],
		// 		// }
		// 	}]
		// },
		/**
   * @Note tpyescript
   * @Steps
   *      1. npm install --save-dev typescript ts-loader
   *      2. create a tsconfig.json
   *      3. insert loader in webpack
   * */
		{
			test: /\.tsx?$/,
			use: 'ts-loader',
			exclude: /node_modules/,
		},
	],
};

const config = {
	mode: 'none',
	module: _module,
	entry,
	output,
	devServer,
	resolve,
	plugins,
};

module.exports = config;