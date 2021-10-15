const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const babelLoaderQuasar = require('./loaders/babel-loader-quasar')
// const stylus = require('./loaders/stylus')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.append('js', babelLoaderQuasar)
// environment.loaders.append('stylus', stylus)
environment.loaders.prepend('vue', vue)
module.exports = environment
