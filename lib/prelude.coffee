#
_ = require 'lodash'

_.mixin
  value: (value) ->
    if _.isFunction(value)
      value.call()
    else
      value

module.exports = _
