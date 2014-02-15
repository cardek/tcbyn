###*
  @fileoverview .
###
goog.provide 'app.photos.Component'

goog.require 'este.ui.Component'
goog.require 'app.photos.react'
goog.require 'goog.events.EventType'
goog.require 'sms.events.InfinitePageScrollHandler'

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
    @photos = [
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
    ,
      'networkClass': 'type-insta'
      'src': '/client/app/img/03.jpg'
    ,
      'networkClass': 'type-vine'
      'src': '/client/app/img/04.jpg'
    ,
      'networkClass': 'type-vine'
      'src': '/client/app/img/05.jpg'
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

    @scrollHandler = new sms.events.InfinitePageScrollHandler goog.bind @onScrollLoad, @
    @scrollHandler.threshold = 100
    return

  ###*
    @override
  ###
  enterDocument: ->
    super()
    @on '.detail-btn', goog.events.EventType.CLICK, @onDetailClick
    @on '.close', goog.events.EventType.CLICK, @onCloseClick
    @on '.fake', goog.events.EventType.CLICK, @onFakeClick
    @on '.wrong-category', goog.events.EventType.CLICK, @onWrongCategoryClick

    @scrollHandler.setEnabled on
    return

  ###*
    @override
  ###
  exitDocument: ->
    super()
    @scrollHandler.setEnabled off
    return

  ###*
    @protected
  ###
  onWrongCategoryClick: (e) ->
    @thanksForVote()

  ###*
    @protected
  ###
  onFakeClick: (e) ->
    @thanksForVote()

  ###*
    @protected
  ###
  onDetailClick: (e) ->
    @detail =
      'networkClass': 'type-insta'
      'src': '/client/app/img/02.jpg'
    @update()
    @detailPicResize()

  detailPicResize: ->
    lightbox = @dom_.getElementByClass 'in-detail-lightbox', @getElement()
    img = @dom_.getElementByClass 'img', lightbox
    desc = @dom_.getElementByClass 'desc', lightbox

    size = goog.style.getSize lightbox
    goog.style.setStyle img, 'width', size.width + 'px'
    w = size.width - (size.height + 30)
    goog.style.setStyle desc, 'width', w + 'px'

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
      'isLoading': @isLoading
      'detail': @detail
      'user': @user
      'photos': @photos

    if !@react
      @react = app.photos.react props
      este.react.render @react, @getElement()
    else
      @react.setProps props

  ###*
    @protected
  ###
  onScrollLoad: (restart) ->
    unless @endOfPage
      @isLoading = yes
      @update()
      setTimeout =>
        cloned = goog.array.clone @photos
        @photos = goog.array.concat cloned, @photos
        @isLoading = no
        @update()
        restart()
      , 1500
    else
      restart()

  thanksForVote: ->
    el = @dom_.getElement 'notification-container'
    @dom_.setTextContent el, 'Thanks for your vote!'
    goog.dom.classes.enable el, 'act', yes
    setTimeout ->
      goog.dom.classes.enable el, 'act', no
    , 2000
