#
#
React = require 'react'
$ = React.createElement

Attachment = require '../attachment'

module.exports = (config) ->
  __renderItems = (items, props) ->
    props.className ?= 'm-autocomplete'
    props.className += ' focus' if @state.focus

    $ 'div', props,
      $ 'ul', null, do =>
        for item, index in items
          __renderItem.call @, item, index

  __renderItem = (item, index) ->
    $ 'li',
      key: index
      onClick: (e) =>
        @setState value: item.value, __autocomplete_items: false, =>
          @focus()
      config.render item

  componentDidMount: ->
    target = React.findDOMNode @

    props =
      style: {width: target.offsetWidth}

    # @__autocomplete_attachment = new Attachment
    #   target: target
    #   constraints: [
    #     { to: 'scrollParent', attachment: 'together' },
    #     { to: 'window', attachment: 'together' }
    #   ]
    #   onCloseRequest: =>
    #     @setState __autocomplete_items: null
    #   render: =>
    #     if @state && @state.__autocomplete_items
    #       __renderItems.call @, @state.__autocomplete_items, props

  componentDidUpdate: ->
    # @__autocomplete_attachment.update()

  componentWillUnmount: ->
    # @__autocomplete_attachment.destroy()

  prepare: (props) ->
    updateItems = (orig) =>
      (e) =>
        if @state.__autocomplete_items == false
          @state.__autocomplete_items = undefined
        else
          promise = config.query(e.target.value).then (items) =>
            @setState __autocomplete_items: items if @state.focus
          @refs['indicator']?.track?(promise)
        orig? e

    props.onChange = do (orig = props.onChange) => updateItems orig
    props.onFocus = do (orig = props.onFocus) => updateItems orig
    props.classList.push 'm-autocompleted'
