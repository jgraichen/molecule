#
React = require 'react'
$ = React.createElement

Component = require './component'

class Group extends Component
  prepare: (props) ->
    super props

    props.classList.push 'm-group'

  renderComponent: (props) ->
    $ 'div', props, props.children

module.exports = Group
