###*
  @fileoverview Collection representing pageFilters.
###
goog.provide 'app.photos.Collection'

goog.require 'este.Collection'
goog.require 'app.photos.Model'

class app.photos.Collection extends este.Collection

  ###*
    @param {Array=} array
    @constructor
    @extends {este.Collection}
  ###
  constructor: (@user_id, array) ->
    @model = app.photos.Model
    super array
  
  ###*
    @type {Number}
  ###
  user_id: null
  
  ###*
    @override
  ###
  model: app.photos.Model

  ###*
    @override
  ###
  url: "/user"
  
  ###*
    @override
  ###
  getUrl: ->
    "/user/#{@user_id}"
    
    
  ###*
    @param {Array.<Object|este.Model>|Object|este.Model} arg
    @return {boolean} True if any element were added.
    @override
  ###
  add: (arg) ->
    array = if goog.isArray arg then arg else [arg]
    added = []
    for item in array
      item = new @model item if !(item instanceof @model)
      
      console.log item
      
      @ensureUnique item
      item.addParent @ if item instanceof este.Base
      added.push item
    return false if !added.length
    @array.push.apply @array, added
    @sortInternal()
    @dispatchAddEvent added
    true