###*
  @fileoverview app.photos.react.
###
goog.provide 'app.photos.react'

goog.require 'este.react'

app.photos.react = este.react.create (`/** @lends {React.ReactComponent.prototype} */`)

  render: ->
    @section [
      @ul 'className': 'list', [
        @renderPhoto photo for photo in @props['photos']
      ]
      if @props['isLoading']
        @div 'className': 'loading', @img
          'src': '/client/app/img/loading.gif'
      @div 'className': 'overlay act' if @props['detail'] or not @props['user']
      @renderStart() unless @props['user']
      @renderDetail @props['detail'] if @props['detail']
      @i 'className': 'tooltip'
    ]

  renderPhoto: (photo) ->
    @li [
      @article [
        @a
          'className': "detail-btn #{photo['networkClass']}"
        , [
          @span 'className': 'view', [
            @i 'VIEW'
          ]
          @img 'src': photo['src']
        ]
        @div 'className': 'more', [
          @a
            'className': 'fake'
          , [
            @i ''
          ]
          @a
            'className': 'wrong-category'
          , [
            @i ''
          ]
        ]
      ]
    ]

  renderStart: ->
    @div 'className': 'lightbox start-lightbox act', [
      @header [
        @h1 [
          @a 'href': '/', 'this could be your neighbor!'
        ]
      ]
      @ol [
        @li [
          @h2 '100% real profiles'
          @p 'This girls and boys are REAL. For real. And if you find some fake photos - click the fake button and no more fake photos and videos from that account ;)'
        ]
        @li [
          @h2 'No dicks!'
          @p 'If you don’t want! You know, we’re not homophobic and girls are welcome here. If you see a dick and don’t want to - just click the button. No more dicks and opposite.'
        ]
        @li [
          @h2 'Finally - find your perverted neighbor!'
          @p 'I mean, there must be her naked photos somewhere!'
        ]
      ]

      @div 'className': 'select-gender', [
        @h2 'I want to see'
        @div 'className': 'choose-switcher', [
          @i 'className': 'arrow-left'
          @i 'className': 'arrow-right'

          @a
            'className': 'select-type-btn switcher-0'
          , 'Boys'
          @div 'className': 'switcher'
          @a
            'className': 'select-type-btn switcher-2'
          , 'Girls'
        ]
      ]
      @p 'className': 'copy', 'By selecting the gender you agree to our terms and conditions and you are confirming you are over 18 years old.'

    ]

  renderDetail: (photo) ->
    @div 'className': 'lightbox detail-lightbox act', [
      @a
        'className': 'btn-listing prev'
      @div 'className': "in-detail-lightbox #{photo['networkClass']}", [
        @a
          'className': 'close'
        , 'CLOSE'
        @div 'className': 'img', [
          @i 'className': 'border'
          @img 'src': '/client/app/img/detail.jpg'
        ]
        @div 'className': 'desc', [
          @a
            'className': 'user'
            '_target': 'blank'
          , [
            @i [
              @img
                'src': '/client/app/img/user.jpg'
                'alt': ''
            ]
            @span 'christymack'
          ]
          @br
          @h1 'Non filtered, non made up Mack. Nothing but my lash extensions.'
          @p 'className': 'date', [
            '10.11 pm 1/30/2014'
            @br
          ]
          @div 'className': 'maps', [
            @p [
              'This hot babe is from'
              @strong 'Las Vegas, TX'
            ]
          ]
          @div 'className': 'other-social', [
            @p 'Try her other social media profiles'
            @ul
              @li @a
                'className': 'twitter'
                'target': '_blank'
              , 'Twitter'
              @li @a
                'className': 'insta'
                'target': '_blank'
              , 'Instagram'
              @li @a
                'className': 'vine'
                'target': '_blank'
              , 'Vine'
          ]
        ]
        @i 'className': 'border'
      ]
      @a
        'className': 'btn-listing prev'
    ]
