var base = require('./base.config.js');
base.entry = {full: './app/index.coffee'}
base.output = {path: './electron', publicPath: '/', filename: 'app.js'}
module.exports = base
