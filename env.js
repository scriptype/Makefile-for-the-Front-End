var path = require('path')

module.exports = {
  prod: {
    staticfiles: path.resolve('dist')
  },
  dev: {
    staticfiles: path.resolve('.')
  }
}
