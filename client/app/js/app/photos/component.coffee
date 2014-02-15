###*
  @fileoverview .
###
goog.provide 'app.photos.Component'

goog.require 'este.ui.Component'
goog.require 'app.photos.react'

class app.photos.Component extends este.ui.Component

  ###*
    @param {este.storage.Base} storage
    @constructor
    @extends {este.ui.Component}
  ###
  constructor: (@storage) ->
    super()

  ###*
    @type {este.storage.Base}
    @protected
  ###
  storage: null

  ###*
    @type {React.ReactComponent}
    @protected
  ###
  react: null

  ###*
    @override
  ###
  createDom: ->
    super()
    @getElement().className = 'photos-viewer'
    @update()
    return

  ###*
    @override
  ###
  enterDocument: ->
    super()
    return

  ###*
    @protected
  ###
  update: ->
    props =
      'photos': []

    if !@react
      @react = app.photos.react props
      este.react.render @react, @getElement()
    else
      @react.setProps props
