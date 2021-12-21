const path = require('path')
const resolve_relative = function (dir) {
  return path.join(__dirname, '../../../app/javascript/app', dir)
}

module.exports = {
  resolve: {
    alias: {
      'images': resolve_relative('assets/images'),
      'components': resolve_relative('components'),
      'mixins': resolve_relative('mixins')
    }
  }
}