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
    @isLoading = yes
    @update()
    result = @storage.query @photos
    goog.result.waitOnSuccess result, (e) =>
      @isLoading = no
#      console.log @photos.lastLoadedId()
      @update()

    @scrollHandler = new sms.events.InfinitePageScrollHandler goog.bind @onScrollLoad, @
    @scrollHandler.threshold = 100
    return

  ###*
    @override
  ###
  enterDocument: ->
    super()
    @on '.detail-btn', goog.events.EventType.CLICK, @bindModel @onDetailClick
    @on '.close', goog.events.EventType.CLICK, @onCloseClick
    @on '.fake', goog.events.EventType.CLICK, @onFakeClick
    @on '.wrong-category', goog.events.EventType.CLICK, @onWrongCategoryClick
    @on @photos, este.Model.EventType.UPDATE, @onCollectionUpdate
    @on '.switcher-0', goog.events.EventType.CLICK, @onBoysClick
    @on '.switcher-2', goog.events.EventType.CLICK, @onGirlsClick
    @on '.btn-filter', goog.events.EventType.CLICK, @onBtnFilterClick
    @on 'button', goog.events.EventType.CLICK, @onFilterSubmit
    @on '.checkbox-photos', goog.events.EventType.CLICK, @onCheckboxPhotosClick
    @on '.checkbox-videos', goog.events.EventType.CLICK, @onCheckboxVideosClick
    @on '#filter-close', goog.events.EventType.CLICK, @onFilterCloseClick
    @on '.filter-switcher-0', goog.events.EventType.CLICK, @onFilterBoysClick
    @on '.filter-switcher-2', goog.events.EventType.CLICK, @onFilterGirlsClick

    @on @, goog.events.KeyCodes.ENTER, @onEscClick

    @scrollHandler.setEnabled on
    return

  ###*
    @protected
  ###
  onFilterBoysClick: ->
    @user['gender'] = 'boys'

  ###*
    @protected
  ###
  onFilterBoysClick: ->
    @user['gender'] = 'girls'

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
    @update()

  ###*
    @protected
  ###
  onGirlsClick: ->
    @user = 'gender': 'girls'
    
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
  onEscClick: (e) ->
    console.log e
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
    console.log "t"
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
