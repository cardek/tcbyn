###*
  @fileoverview Model representing one page filter.
###
goog.provide 'app.photos.Model'

goog.require 'este.Model'

class app.photos.Model extends este.Model

  ###*
    @param {Object=} json
    @constructor
    @extends {este.Model}
  ###
  constructor: (json) ->
    super json