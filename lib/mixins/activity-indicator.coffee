React = require 'react'
$ = React.createElement

ActivityIndicator = require '../activity-indicator'

#
module.exports = (config = {}) ->
  prepare: (props) ->
    props.children.push $ ActivityIndicator, ref: 'indicator', key: 'indicator', size: config.size
