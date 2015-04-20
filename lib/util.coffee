#
util =
  isUnmodifiedEvent: (e) ->
    !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey

  isPrimaryButton: (e) ->
    util.isUnmodifiedEvent(e) && e.button == 0

  onPrimaryButton: (fn) ->
    (e) =>
      fn e if util.isPrimaryButton e

module.exports = util
