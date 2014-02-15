###*
  @fileoverview .
###
goog.provide 'app.home.Presenter'

goog.require 'este.app.Presenter'
goog.require 'app.home.View'

class app.home.Presenter extends este.app.Presenter

  ###*
    @constructor
    @extends {este.app.Presenter}
  ###
  constructor: ->
    super()
    @view = new app.home.View

  ###*
    @override
  ###
  show: ->
    @view.storage = @storage
    return