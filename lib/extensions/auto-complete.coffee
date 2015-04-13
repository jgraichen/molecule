#
#
React = require 'react'
$ = React.createElement

Attachment = require '../attachment'

module.exports = (config) ->
  enabled: true

  componentDidMount: ->
    target = React.findDOMNode @
    width  = target.offsetWidth

    @__autocomplete_attachment = new Attachment
      target: target
      constraints: [
        { to: 'scrollParent', attachment: 'together' },
        { to: 'window', attachment: 'together' }
      ]
      onCloseRequest: =>
        @setState __autocomplete_items: null
      render: =>
        if @state && @state.__autocomplete_items
          className = 'm-autocomplete'
          className += ' focus' if @state.focus

          $ 'div',
            className: className
            style: { width: width }
            $ 'ul', null,
              ($ 'li', null, config.render item for item in @state.__autocomplete_items)

  componentDidUpdate: ->
    @__autocomplete_attachment.update()

  componentWillUnmount: ->
    @__autocomplete_attachment.destroy()

  apply: (props) ->
    updateItems = (orig) =>
      (e) =>
        config.query(e.target.value).then (items) =>
          @setState __autocomplete_items: items
        orig? e

    props.onChange = do (orig = props.onChange) => updateItems orig
    props.onFocus = do (orig = props.onFocus) => updateItems orig

    props.classList.push 'm-autocompleted'
