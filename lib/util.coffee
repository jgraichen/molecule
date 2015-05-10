#
hasOwnProperty = Object.prototype.hasOwnProperty

util =
  isUnmodifiedEvent: (e) ->
    !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey

  isPrimaryButton: (e) ->
    util.isUnmodifiedEvent(e) && e.button == 0

  onPrimaryButton: (fn) ->
    (e) =>
      fn e if util.isPrimaryButton e

  extend: (object, args...) ->
    for arg in args
      if arg != null
        for key, value of arg
          object[key] = value

    object

  copy: (args...) ->
    util.extend {}, args...

module.exports = util
