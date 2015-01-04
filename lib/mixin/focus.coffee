#
module.exports = (config) ->
  getInitialState: ->
    focus: false

  componentDidMount: ->
    @__focusHandler = => @setState focus: true
    @__blurHandler = => @setState focus: false

    if config.ref
      node = @refs[config.ref].getDOMNode()
    else
      node = @getDOMNode()

    node.addEventListener 'focus', @__focusHandler
    node.addEventListener 'blur', @__blurHandler

  componentWillUnmount: ->
    if config.ref
      node = @refs[config.ref].getDOMNode()
    else
      node = @getDOMNode()

    node.removeEventListener 'focus', @__focusHandler
    node.removeEventListener 'blur', @__blurHandler
