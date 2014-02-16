###*
  @fileoverview .
###
goog.provide 'app.photos.Component'

goog.require 'este.ui.Component'
goog.require 'app.photos.react'
goog.require 'goog.events.EventType'
goog.require 'sms.events.InfinitePageScrollHandler'
goog.require 'goog.events.KeyCodes'

goog.require 'app.photos.Collection'

class app.photos.Component extends este.ui.Component

  ###*
    @param {este.storage.Base} storage
    @constructor
    @extends {este.ui.Component}
  ###
  constructor: (@storage) ->
    super()

    @photos = new app.photos.Collection 418283667, 526969411652558850  #482357921 alcie #418283667 vix #agr 601244563 # 20913964 - christy mack #18661601
    @filter =
      'videos': yes
      'photos': yes

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
    @scrollHandler = new sms.events.InfinitePageScrollHandler goog.bind @onScrollLoad, @
    @scrollHandler.threshold = 100
    @isLoading = yes
    @update()
    result = @storage.query @photos
    goog.result.waitOnSuccess result, (e) =>
      @isLoading = no
      @scrollHandler.setEnabled on
      @update()

    return

  ###*
    @override
  ###
  enterDocument: ->
    super()
    @on '.detail-btn', goog.events.EventType.CLICK, @bindModel @onDetailClick
    @on '#detail-close', goog.events.EventType.CLICK, @onCloseClick
    @on '.fake', goog.events.EventType.CLICK, @bindModel @onFakeClick
    @on '.wrong-category', goog.events.EventType.CLICK, @bindModel @onWrongCategoryClick
    @on @photos, este.Model.EventType.UPDATE, @onCollectionUpdate
    @on '.start-switcher-0', goog.events.EventType.CLICK, @onBoysClick
    @on '.start-switcher-2', goog.events.EventType.CLICK, @onGirlsClick
    @on '.btn-filter', goog.events.EventType.CLICK, @onBtnFilterClick
    @on 'button', goog.events.EventType.CLICK, @onFilterSubmit
    @on '.checkbox-photos', goog.events.EventType.CLICK, @onCheckboxPhotosClick
    @on '.checkbox-videos', goog.events.EventType.CLICK, @onCheckboxVideosClick
    @on '#filter-close', goog.events.EventType.CLICK, @onFilterCloseClick
    @on '.filter-switcher-0', goog.events.EventType.CLICK, @onFilterBoysClick
    @on '.filter-switcher-2', goog.events.EventType.CLICK, @onFilterGirlsClick

    @on @, goog.events.KeyCodes.ENTER, @onEscClick
    return

  ###*
    @protected
  ###
  onFilterBoysClick: ->
    @user['gender'] = 'boys'
    switcher = @dom_.getElement 'filter-gender-switcher'
    goog.dom.classes.enable switcher, 'go-right', no
    goog.dom.classes.enable switcher, 'go-left', yes

  ###*
    @protected
  ###
  onFilterGirlsClick: ->
    @user['gender'] = 'girls'
    switcher = @dom_.getElement 'filter-gender-switcher'
    goog.dom.classes.enable switcher, 'go-left', no
    goog.dom.classes.enable switcher, 'go-right', yes

  ###*
    @protected
  ###
  onFilterCloseClick: ->
    filter = @dom_.getElementByClass 'filter', @getElement()
    goog.dom.classes.enable filter, 'act', no

  ###*
    @protected
  ###
  onCheckboxPhotosClick: ->
    @filter['photos'] = not @filter['photos']
    @update()

  ###*
    @protected
  ###
  onCheckboxVideosClick: ->
    @filter['videos'] = not @filter['videos']
    @update()

  ###*
    @protected
  ###
  onFilterSubmit: ->
    filter = @dom_.getElementByClass 'filter', @getElement()
    goog.dom.classes.enable filter, 'act', no

  ###*
    @protected
  ###
  onBtnFilterClick: ->
    filter = @dom_.getElementByClass 'filter', @getElement()
    goog.dom.classes.toggle filter, 'act'

  ###*
    @protected
  ###
  onBoysClick: ->
    @user = 'gender': 'boys'
    switcher = @dom_.getElement 'start-gender-switcher'
    goog.dom.classes.enable switcher, 'go-right', no
    goog.dom.classes.enable switcher, 'go-left', yes
    setTimeout =>
      @update()
    , 200

  ###*
    @protected
  ###
  onGirlsClick: ->
    @user = 'gender': 'girls'
    switcher = @dom_.getElement 'start-gender-switcher'
    goog.dom.classes.enable switcher, 'go-left', no
    goog.dom.classes.enable switcher, 'go-right', yes
    setTimeout =>
      @update()
    , 200

  ###
    On collection update callback function
    @protected
  ###
  onCollectionUpdate: ->
    @update()

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
  onWrongCategoryClick: (model, el) ->
    goog.dom.classes.enable el, 'fadeout', yes
    setTimeout =>
      @photos.remove model
      @dom_.removeNode el
    , 400
    @thanksForVote()

  ###*
    @protected
  ###
  onFakeClick: (model, el) ->
    goog.dom.classes.enable el, 'fadeout', yes
    setTimeout =>
      @photos.remove model
      @dom_.removeNode el
    , 400
    @thanksForVote()

  ###*
    @protected
  ###
  onDetailClick: (model) ->
    @detail = model
    @update()
    @detailPicResize()

  detailPicResize: ->
    lightbox = @dom_.getElementByClass 'in-detail-lightbox', @getElement()
    img = @dom_.getElementByClass 'img', lightbox
    desc = @dom_.getElementByClass 'desc', lightbox

    size = goog.style.getSize lightbox
    goog.style.setStyle img, 'width', size.width + 'px'
    w = size.width - (size.height)
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
  onEscClick: (e) ->
    return unless @detail
    @onCloseClick()

  ###*
    @protected
  ###
  update: ->
    props =
      'filter': @filter
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
#    unless @endOfPage
#      @isLoading = yes
#      @update()
#      
#      max_id = @photos.lastLoadedId()
#      
#      result = @storage.query @photos, max_id
#      goog.result.waitOnSuccess result, (e) =>
#        @isLoading = no
#  #      console.log @photos.lastLoadedId()
#        @update()
#      
#      setTimeout =>
#        cloned = goog.array.clone @photos
#        @photos = goog.array.concat cloned, @photos
#        @isLoading = no
#        @update()
#        restart()
#      , 1500
#    else
#      restart()
      
    unless @endOfPage
      @isLoading = yes
      @update()
      promise = goog.labs.net.xhr.getJson @storage.namespace + "/user/#{@photos.user_id}/#{@photos.max_id}"
      result = goog.result.SimpleResult.fromPromise promise
      goog.result.transform result, (items) =>
        console.log items
        @photos.add items
        @isLoading = no
        @update()
        restart()
    else
      restart()

  thanksForVote: ->
    el = @dom_.getElement 'notification-container'
    @dom_.setTextContent el, 'Thx for vote...'
    goog.dom.classes.enable el, 'act', yes
    setTimeout ->
      goog.dom.classes.enable el, 'act', no
    , 2000
