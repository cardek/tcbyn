###*
  @fileoverview Collection representing pageFilters.
###
goog.provide 'app.photos.Collection'

goog.require 'este.Collection'
goog.require 'app.photos.Model'
goog.require 'goog.string'

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
      entity = item.get 'entities'
      interesting = false
      if entity.urls.length
        for url in entity.urls
          if goog.string.contains url.expanded_url, "instagram.com"
            interesting = true
            item.set 'network','instagram'
            item.set 'media', url.expanded_url
          if goog.string.contains url.expanded_url, "pic.twitter"
            interesting = true
            item.set 'network','twitter'
            item.set 'media', url.expanded_url
          if goog.string.contains url.expanded_url, "vine.co"
            interesting = true
            item.set 'network','vine'
            item.set 'media', url.expanded_url
      if interesting is true
        @ensureUnique item
        item.addParent @ if item instanceof este.Base
        added.push item
    return false if !added.length
    @array.push.apply @array, added
    @sortInternal()
    @dispatchAddEvent added
    true