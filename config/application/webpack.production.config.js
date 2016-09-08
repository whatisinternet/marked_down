var base = require('./base.config.js');
var webpack = require('webpack');
base.entry = {full: './app/index.coffee'}
base.output = {path: './dist', publicPath: '/', filename: 'app.entry.js'}
base.plugins.push(
  new webpack.optimize.DedupePlugin(),
  new webpack.DefinePlugin({
    'process.env': {
      'NODE_ENV': JSON.stringify('production')
    }
  }),
  new webpack.optimize.UglifyJsPlugin()
)
module.exports = base;
