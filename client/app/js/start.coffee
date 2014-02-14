###*
  @fileoverview.
###

goog.provide 'app.start'

goog.require 'este.app.create'
goog.require 'app.home.Presenter'
goog.require 'este.storage.Rest'

app.start = (settings) ->
  console.log 'sss', settings
  tcbynApp = este.app.create settings['selector'], forceHash: true
  tcbynApp.storage = new este.storage.Rest "#{settings['baseUrl']}/api"
  tcbynApp.addRoutes
    '/': new app.home.Presenter
  tcbynApp.run()

# Ensures the symbol will be visible after compiler renaming.
goog.exportSymbol 'app.start', app.start