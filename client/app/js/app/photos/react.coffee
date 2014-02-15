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
      @renderStart() unless @props['user']
    ]

  renderPhoto: (photo) ->
    @li [
      @article [
        @a
          'href': ''
          'className': photo['networkClass']
        , [
          @span 'className': 'view', [
            @i 'VIEW'
          ]
          @img 'src': photo['src']
        ]
        @div 'className': 'more', [
          @a
            'href': ''
            'className': 'fake'
          , [
            @i ''
          ]
          @a
            'href': ''
            'className': 'wrong-category'
          , [
            @i ''
          ]
        ]
      ]
    ]

  renderStart: ->
    @div 'className': 'overlay'
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

      @div 'className': 'choose-switcher', [
        @i 'className': 'arrow-left'
        @i 'className': 'arrow-right'

        @a
          'href': ''
          'className': 'select-type-btn switcher-0'
        , 'Boys'
        @div 'className': 'switcher'
        @a
          'href': ''
          'className': 'select-type-btn switcher-2'
        , 'Girls'
      ]
    ]
