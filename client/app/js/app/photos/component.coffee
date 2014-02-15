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
    @type {Object}
    @protected
  ###
  user: null

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
      'user': @user
      'photos': [
        'networkClass': 'type-vine'
        'src': '/client/app/img/01.jpg'
      ,
        'networkClass': 'type-insta'
        'src': '/client/app/img/02.jpg'
      ,
        'networkClass': 'type-insta'
        'src': '/client/app/img/03.jpg'
      ,
        'networkClass': 'type-vine'
        'src': '/client/app/img/04.jpg'
      ,
        'networkClass': 'type-vine'
        'src': '/client/app/img/05.jpg'
      ]

    if !@react
      @react = app.photos.react props
      este.react.render @react, @getElement()
    else
      @react.setProps props
