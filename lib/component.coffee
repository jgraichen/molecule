#
React = require 'react'

excludeMethods =
  componentDidMount: true,
  componentWillUnmount: true,
  componentDidUpdate: true,
  prepare: true,
  included: true

forEachMixin = (fn) ->
  forEachMixinSuper.call @.constructor, fn
  fn mx for mx in @props.mixins if @props.mixins?

forEachMixinSuper = (fn) ->
  if @__super__?
    forEachMixinSuper.call @__super__, fn
  fn mx for mx in @__mixins__ if @__mixins__?

class Component extends React.Component
  #
  # Include mixin to class.
  #
  @include = (mixin, config = {}) ->
    if typeof mixin == 'function'
      mixin = mixin config

    for name, _ of mixin when not excludeMethods[name]
      @prototype[name] = do (fn = name, mx = mixin) => -> mx[fn].apply @, arguments

    mixin.included?.call @

    @__mixins__ ?= []
    @__mixins__.push mixin

  constructor: (props) ->
    super props

    @state = {}

  componentDidMount: ->
    forEachMixin.call @, (mx) =>
      mx.componentDidMount?.call @

  componentWillUnmount: ->
    forEachMixin.call @, (mx) =>
      mx.componentWillUnmount?.call @

  componentDidUpdate: ->
    forEachMixin.call @, (mx) =>
      mx.componentDidUpdate?.call @

  prepare: (props) ->
    forEachMixin.call @, (mx) =>
      mx.prepare?.call @, props

  render: ->
    @prepared @renderComponent

  prepared: (fn) ->
    # Create new props object with empty
    # `className` and `classList`. This way we do not have
    # to check if `className` exists before splitting nor
    # if `classList` exists before adding elements.
    props = className: '', classList: [], children: []

    # Copy properties from components props into new props.
    props[key] = value for key, value of @props

    # Split given class names and add to the front of
    # `classList`. `className` should always be a `String` here.
    props.classList.unshift props.className.split(/\s+/)...

    # Unset class name - use class list
    props.className = ''

    # Run prepare function
    @prepare? props

    # Override `className` with classes from `classList`.
    # The `className` property should not be used in `fn`
    # not in extensions.
    props.className = props.classList.join(' ').trim()

    # Cleanup
    delete props.classList

    # Run actual render function or return props
    if fn? then fn props else props

module.exports = Component
