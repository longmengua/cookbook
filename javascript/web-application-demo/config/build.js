const {CleanWebpackPlugin} = require("clean-webpack-plugin");
const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");

const root = path.resolve("");

const devServer = {
	port: 1234,
	index: "index.html",
	contentBase: path.resolve("dist"),
	contentBasePublicPath: '/demo',
	compress: true,
	hot: true,
	// useLocalIp: true,
	// When devServer.lazy is enabled, the dev-server will only compile the bundle when it gets requested.
	// This means that webpack will not watch any file changes. We call this lazy mode.
	lazy: true,
	https: true,
	headers: {
		"test-header":"demo-header"
	},
	historyApiFallback: {
		// index: 'dist/index.html',
		// rewrites: [
		// 	// { from: /^\/$/, to: '/demo' },
		// 	{ from: /^\/subpage/, to: '/dist/index.html' },
		// 	{ from: /./, to: '/404.html' }
		// ]
	}
};

const resolve = {
	extensions: [ '.tsx', '.ts', '.js', '.css', '.sass', '.scss' ],
	modules: ["node_modules"],
};

const entry = {
	index: "./src/index_r.tsx",
};

const output = {
	path: path.resolve("dist"),
	filename: "[hash:10].[name].js",
};

const plugins = [
	new webpack.HotModuleReplacementPlugin(),
	new HtmlWebpackPlugin({
		template: 'index.html'
	}),
	new CleanWebpackPlugin(),//could not execute with turing on hot-reload option.
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
		{
			test: /\.(png|jpe?g|gif)$/i,
			loader: 'file-loader',
			options: {
				publicPath: 'assets',
			},
		},
	],
};

//https://juejin.im/post/6844903450644316174
const devtool = "cheap-module-source-map";

const performance = {
	hints: "warning",
	maxEntrypointSize: 512000,
	maxAssetSize: 512000,
};

const optimization = {
	usedExports: true,
	splitChunks: {
		chunks: "async",//async, all,
		minSize: 20000,
		// minRemainingSize: 0,
		maxSize: 0,
		minChunks: 1,
		maxAsyncRequests: 30,
		maxInitialRequests: 30,
		automaticNameDelimiter: "-",
		enforceSizeThreshold: 50000,
		cacheGroups: {
			defaultVendors: {
				test: /node_modules/,
				priority: -10
			},
			default: {
				minChunks: 2,
				priority: -20,
				reuseExistingChunk: true
			}
		}
	}
};

const config = {
	mode: 'production',//set up as production will auto minify the js files.
	module: _module,
	entry,
	output,
	devServer,
	resolve,
	plugins,
	devtool,
	performance,
	optimization
};

module.exports = config;