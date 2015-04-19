React = require 'react'

#
module.exports = ->
  componentDidMount: ->
    window.addEventListener 'resize', @onResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @onResize
