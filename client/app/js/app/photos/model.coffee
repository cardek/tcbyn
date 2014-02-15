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
    
    
  setAttributes: (json) ->
    super json
    if goog.isArray @get 'platform_metrics'
      platform_metrics = new app.datamining.dashboard.platformMetrics.Collection (`/** @type {Array} */`) @get 'platform_metrics'
      @attributes['expanded_url'] = platform_metrics