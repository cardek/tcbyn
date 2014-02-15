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
  constructor: (array) ->
    @model = app.photos.Model
    super array

  ###*
    @override
  ###
  model: app.photos.Model
