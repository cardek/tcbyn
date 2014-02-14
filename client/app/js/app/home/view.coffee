###*
  @fileoverview .
###
goog.provide 'app.home.View'

goog.require 'app.home.react'
goog.require 'este.app.View'

class app.home.View extends este.app.View

  ###*
    @constructor
    @extends {este.app.View}
  ###
  constructor: ->
    super()

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
    @update()
    return

  ###*
    @override
  ###
  enterDocument: ->
    super()
    return

  ###*
    Template render method.
    @override
  ###
  update: ->
    props = {}

    if !@react
      @react = app.home.react props
      este.react.render @react, @getElement()
    else
      @react.setProps props
    return