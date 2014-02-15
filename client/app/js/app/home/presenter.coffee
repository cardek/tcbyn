###*
  @fileoverview .
###
goog.provide 'app.home.Presenter'

goog.require 'este.app.Presenter'
goog.require 'app.home.View'
goog.require 'app.accounts.Model'

class app.home.Presenter extends este.app.Presenter

  ###*
    @constructor
    @extends {este.app.Presenter}
  ###
  constructor: ->
    super()
    @view = new app.home.View

  ###*
    Model of one twitter account.
    @type {app.accounts.Model}
    @protected
  ###
  account: null

  ###*
    Load data for view.
    @override
  ###
  load: (params) ->
    @account = new app.accounts.Model 418283667
    @storage.load @account

  ###*
    @override
  ###
  show: ->
    @view.storage = @storage
    return