var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var config = require('./application/webpack.config');

new WebpackDevServer(webpack(config),{
  publicPath: config.output.publicPath,
  hot: false,
  historyApiFallback: true
}).listen(8080, 'localhost', function (err) {
  if (err) {
    console.log(err);
  }

  console.log('Server is now running on localhost:8080');

});

