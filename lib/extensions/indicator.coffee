React = require 'react'
$ = React.createElement

Indicator = require '../indicator'

#
module.exports = (config) ->
  enabled: true

  apply: (props) ->
    props.children ?= []
    props.children.push $ Indicator, ref: 'indicator', key: 'indicator', size: config.size
