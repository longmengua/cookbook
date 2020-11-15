const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");

const root = path.resolve("");

const devServer = {
	port    : 1234,
	// Index: path.resolve("index.html"),
	// ContentBase: path.resolve("dist"),
	// ContentBasePublicPath: '/demo',
	compress: true,
	hot     : true,
	// Lazy: true,
	// UseLocalIp: true,
	// When devServer.lazy is enabled, the dev-server will only compile the bundle when it gets requested.
	// This means that webpack will not watch any file changes. We call this lazy mode.
	https   : true,
	headers : {
		"test-header": "demo-header"
	},
	historyApiFallback: {
		// Index: 'dist/index.html',
		// Rewrites: [
		// 	// { from: /^\/$/, to: '/demo' },
		// 	{ from: /^\/subpage/, to: '/dist/index.html' },
		// 	{ from: /./, to: '/404.html' }
		// ]
	}
};

const resolve = {
	extensions: [
		'.tsx',
		'.ts',
		'.js',
		'.css',
		'.sass',
		'.scss'
	],
	modules: [ "node_modules" ],
};

const entry = {
	index: "./src/index_r.tsx"
};

const output = {
	path         : path.resolve("dist"),
	filename     : "[contenthash:10].[name].js",
	chunkFilename: '[contenthash:10].[name].js',
};

const plugins = [
	new HtmlWebpackPlugin({
		template: 'index.html'
	}),
	(new webpack.HotModuleReplacementPlugin),// When using hot-reload, the CleanWebpackPlugin and devServer.lazy cannot turn on.
	// New CleanWebpackPlugin(),
];

const _module = {
	rules: [

		/**
		 * @Note babel parsing jsx
		 * */
		// {
		// 	Test: /\.jsx?$/,
		// 	Exclude: /node_modules/,
		// 	Include: [
		// 		Path.resolve("src")
		// 	],
		// 	Use: [{
		// 		Loader: 'babel-loader',
		// 		/**
		// * @Note this configuration is react
		// * */
		// 		// options: {
		// 		//     presets: ['@babel/preset-react'],
		// 		// }
		// 	}]
		// },
		// {
		// 	Test: /\.vue$/,
		// 	Loader: 'vue-loader',
		// 	Exclude: /node_modules/,
		// 	Include: [
		// 		Path.resolve("src/Vue")
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
			test   : /\.tsx?$/,
			exclude: /node_modules/,
			include: path.resolve("src"),
			use    : 'ts-loader',
		},
		{
			test   : /\.css$/i,
			exclude: /node_modules/,
			include: path.resolve('src'),
			use    : [
				'style-loader',
				'css-loader',
			],
		},
		{
			test   : /\.s[ac]ss$/i,
			exclude: /node_modules/,
			include: path.resolve('src'),
			use    : [
				'style-loader',
				'css-loader',
				'sass-loader',
			],
		},
		{
			test  : /\.(png|jpe?g|gif)$/i,
			loader: 'file-loader',
		},
	],
};

//https://juejin.im/post/6844903450644316174
const devtool = "source-map";

const performance = {
	hints            : "warning",
	maxEntrypointSize: 512000,
	maxAssetSize     : 512000,
};

const optimization = {
	usedExports : true,
	runtimeChunk: true,
	splitChunks : {
		chunks                : "async",//Async, all,
		minSize               : 0,
		// MinRemainingSize: 0,
		maxSize               : 20000,
		minChunks             : 1,
		maxAsyncRequests      : 30,
		maxInitialRequests    : 30,
		automaticNameDelimiter: ".",
		enforceSizeThreshold  : 50000,
		cacheGroups           : {
			defaultVendors: {
				test    : /node_modules/,
				priority: -10
			},
			commons: {
				chunks   : 'initial',
				name     : 'commons', //分割出來的檔案命名
				minChunks: 2, //被引入2次以上的code就會被提取出來
				priority : 1, //檔案的優先順序，數字越大表示優先級越高
			},
			vendor: {
				test    : /node_modules/, //提取引入的模組
				chunks  : 'initial',
				name    : 'vendor', //分割出來的檔案命名
				priority: 2, //檔案的優先順序，數字越大表示優先級越高
				enforce : true
			}
		}
	}
};

const config = {
	mode  : 'development',//Development, production //set up as production will auto minify the js files.
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