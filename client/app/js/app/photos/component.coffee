###*
  @fileoverview .
###
goog.provide 'app.photos.Component'

goog.require 'este.ui.Component'
goog.require 'app.photos.react'
goog.require 'goog.events.EventType'

class app.photos.Component extends este.ui.Component

  ###*
    @param {este.storage.Base} storage
    @constructor
    @extends {este.ui.Component}
  ###
  constructor: (@storage) ->
    super()

    # remove if slider is implemented
    @user = 'gender': 'girls'

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
    @on '.detail-btn', goog.events.EventType.CLICK, @onDetailClick
    @on '.close', goog.events.EventType.CLICK, @onCloseClick
    return

  ###*
    @protected
  ###
  onDetailClick: (e) ->
    @detail =
      'networkClass': 'type-insta'
      'src': '/client/app/img/02.jpg'
    @update()

  ###*
    @protected
  ###
  onCloseClick: (e) ->
    @detail = null
    @update()

  ###*
    @protected
  ###
  update: ->
    props =
      'detail': @detail
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
