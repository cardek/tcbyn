###*
  @fileoverview app.photos.react.
###
goog.provide 'app.photos.react'

goog.require 'este.react'

app.photos.react = este.react.create (`/** @lends {React.ReactComponent.prototype} */`)

  render: ->
    @div 'photos'