exports.index = (req, res) ->
  res.render 'app/index',
    title: 'Este.js'
    appVersion: require('../../../package.json').version