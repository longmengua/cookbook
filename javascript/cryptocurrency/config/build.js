const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");

const devServer = {
	port    : 1234,
	compress: true,
	hot     : true,
	https   : true,
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
	index: "./src/main.tsx"
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
	(new webpack.HotModuleReplacementPlugin),// when using hot-reload, the CleanWebpackPlugin and devServer.lazy cannot turn on.
	// new CleanWebpackPlugin(),
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
		chunks                : "async",//async, all,
		minSize               : 0,
		// minRemainingSize: 0,
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
	mode  : 'development',//development, production //set up as production will auto minify the js files.
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