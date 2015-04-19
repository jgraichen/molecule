#
React = require 'react'
$ = React.createElement

Component = require './component'

class Panel extends Component
  prepare: (props) =>
    super props

    props.classList.push 'm-panel'

  renderComponent: (props) =>
    $ 'div', props, props.children

module.exports = Panel
