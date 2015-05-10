#
React = require 'react'

util = require './util'

excludeMethods =
  componentDidMount: true,
  componentWillUnmount: true,
  componentDidUpdate: true,
  prepare: true,
  included: true

forEachMixin = (fn) ->
  forEachClassMixin.call @.constructor, fn

  if @props.mixins?
    for mx in @props.mixins
      fn mx

forEachClassMixin = (fn) ->
  if @mixins?
    for mx in @mixins
      fn mx

class Component extends React.Component
  @mixins: []
  @include: (mixin, cfg) ->
    if typeof mixin == 'function'
      mixin = mixin cfg

    for name, _ of mixin when not excludeMethods[name]
      @::[name] = do (fn = name, mx = mixin) =>
        -> mx[fn].apply @, arguments

    @mixins = @mixins.slice 0
    @mixins.push mixin

  constructor: (props) ->
    super util.copy @defaultProps, props

    @state = {}

  componentDidMount: =>
    forEachMixin.call @, (mx) =>
      mx.componentDidMount?.call @

  componentWillUnmount: =>
    forEachMixin.call @, (mx) =>
      mx.componentWillUnmount?.call @

  componentDidUpdate: =>
    forEachMixin.call @, (mx) =>
      mx.componentDidUpdate?.call @

  prepare: (props) =>
    forEachMixin.call @, (mx) =>
      mx.prepare?.call @, props

  render: =>
    @prepared @renderComponent

  prepared: (fn) =>
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
