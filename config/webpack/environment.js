const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const babelLoaderQuasar = require('./loaders/babel-loader-quasar')
const stylus = require('./loaders/stylus')
const pug = require('./loaders/pug')
const vue = require('./loaders/vue')
const aliases = require('./utils/aliases')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.append('js', babelLoaderQuasar)
environment.loaders.append('stylus', stylus)
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('pug', pug)
environment.config.merge(aliases)

module.exports = environment
