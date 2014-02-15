###*
  @fileoverview Model representing dashboard form.
###
goog.provide 'app.accounts.Model'

goog.require 'este.Model'

goog.require 'app.photos.Collection'

class app.accounts.Model extends este.Model

  ###*
    @param {Object=} json
    @constructor
    @extends {este.Model}
  ###
  constructor: (@user_id,json) ->
    super json

  ###*
    @override
  ###
  url: "/user/timeline"
  
  ###*
    @override
  ###
  getUrl: ->
    "/user/timeline/#{@user_id}"
  
  ###*
    @type {Number}
  ###
  user_id: null
  
  ###*
    @override
    @protected
    @desc Method additionally converts children array to collection.
  ###
  setAttributes: (json) ->
    super json
    if goog.isArray @get 'photos'
      photos = new app.photos.Collection (`/** @type {Array} */`) @get 'photos'
      @attributes['photos'] = photos
    return

