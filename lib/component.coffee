#
React = require 'react'
assign = require 'object-assign'

excludeMethods =
  componentDidMount: true,
  componentWillUnmount: true,
  componentDidUpdate: true,
  included: true

class Component extends React.Component
  @include = (mixin, config = {}) ->
    if typeof mixin == 'function'
      mixin = mixin config

    for name, _ of mixin when not excludeMethods[name]
      @prototype[name] = do (fn = name, mx = mixin) => -> mx[fn].apply @, arguments

    mixin.included?.call @

    @__mixins__ ?= []
    @__mixins__.unshift mixin

    @

  constructor: (props) ->
    super props

    @state = {}

  componentDidMount: ->
    if @.constructor.__mixins__?
      mx.componentDidMount?.call @ for mx in @.constructor.__mixins__

  componentWillUnmount: ->
    if @.constructor.__mixins__?
      mx.componentWillUnmount?.call @ for mx in @.constructor.__mixins__

  componentDidUpdate: ->
    if @.constructor.__mixins__?
      mx.componentDidUpdate?.call @ for mx in @.constructor.__mixins__

module.exports = Component
