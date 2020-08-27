import path from 'path';
import webpack from 'webpack';
import HtmlWebpackPlugin from 'html-webpack-plugin';

module.exports = {
	devtool: 'cheap-eval-source-map',
	entry: [
		'webpack-dev-server/client?http://localhost:8080',
		'webpack/hot/dev-server',
		'./src/index'
	],
	output: {
		path: path.join(path.__dirname, 'dist'),
		filename: 'bundle.js'
	},
	plugins: [
		new webpack.HotModuleReplacementPlugin(),
		new HtmlWebpackPlugin({
			template: './src/index.html'
		})
	],
	module: {
		loaders: [
			// {
			//     test: /\.(ts|tsx)$/,
			//     include: env.src,
			//     loader: "ts-loader",
			//     options: {
			//         configFile: env.tsConfig,
			//         transpileOnly: true,
			//         getCustomTransformers: () => ({
			//             before: [TSImportPlugin({libraryName: "antd", libraryDirectory: "es", style: true})],
			//         }),
			//     },
			// },{
			//     test: /\.css$/,
			//     loaders: ['style', 'css']
			// },
		]
	},
	devServer: {
		contentBase: './dist',
		hot: true
	}
};