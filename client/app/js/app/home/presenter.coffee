###*
  @fileoverview .
###
goog.provide 'app.home.Presenter'

goog.require 'este.app.Presenter'
goog.require 'app.home.View'
goog.require 'app.photos.Collection'

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
    @type {app.photos.Collection}
    @protected
  ###
  photos: null

  ###*
    Load data for view.
    @override
  ###
  load: (params) ->
    @photos = new app.photos.Collection 418283667 #482357921 alcie #418283667 vix #agr 601244563
    res =  @storage.query @photos
    
    goog.result.waitOnSuccess res, =>
      console.log @photos

  ###*
    @override
  ###
  show: ->
    @view.storage = @storage
    return