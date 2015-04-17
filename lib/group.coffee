#
React = require 'react'
$ = React.createElement

class Group extends React.Component
  prepare: (props) ->
    super props

    props.classList.push 'm-group'

  renderComponent: (props) ->
    $ 'div', props, props.children

module.exports = Group
