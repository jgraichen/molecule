#
React = require 'react'

{button} = React.DOM

Button = React.createClass
  render: ->
    button null,
      "ABC"

module.exports = Button
