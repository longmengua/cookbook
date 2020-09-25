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
	extensions: [ '.tsx', '.ts', '.js', '.css', '.sass', '.scss' ],
	modules: ["node_modules"],
};

const entry = {
	index_r: "./src/index_r.tsx",
};

const output = {
	path: path.resolve("dist"),
	filename: "[name].js",
};

const plugins = [
	new webpack.HotModuleReplacementPlugin(),
	new HtmlWebpackPlugin({
		template: 'index.html'
	}),
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
		// {
		// 	test: /\.vue$/,
		// 	loader: 'vue-loader',
		// 	exclude: /node_modules/,
		// 	include: [
		// 		path.resolve(root,"src/Vue")
		// 	],
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
			exclude: /node_modules/,
			include: path.resolve(root,"src"),
			use: 'ts-loader',
		},
		{
			test: /\.css$/i,
			exclude: /node_modules/,
			include: path.resolve(root,'src'),
			use: [
				'style-loader',
				'css-loader',
			],
		},
		{
			test: /\.s[ac]ss$/i,
			exclude: /node_modules/,
			include: path.resolve(root,'src'),
			use: [
				'style-loader',
				'css-loader',
				'sass-loader',
			],
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