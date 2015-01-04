#
#
React = require 'react'
$ = React.createElement

Attachment = require '../attachment'

module.exports = (config) ->
  enabled: true

  componentDidMount: ->
    @__autocomplete_attachment = new Attachment
      target: @getDOMNode()
      constraints: [
        { to: 'scrollParent', attachment: 'together' },
        { to: 'window', attachment: 'together' }
      ]
      onCloseRequest: =>
        @setState __autocomplete_items: null
      render: =>
        if @state && @state.__autocomplete_items
          $ 'ul', null,
            ($ 'li', null, config.render item for item in @state.__autocomplete_items)

  componentDidUpdate: ->
    @__autocomplete_attachment.update()

  componentWillUnmount: ->
    @__autocomplete_attachment.destroy()

  apply: (props, classList) ->
    updateItems = (orig) =>
      (e) =>
        config.query(e.target.value).then (items) =>
          @setState __autocomplete_items: items
        orig? e

    props.onChange = do (orig = props.onChange) => updateItems orig
    props.onFocus = do (orig = props.onFocus) => updateItems orig
