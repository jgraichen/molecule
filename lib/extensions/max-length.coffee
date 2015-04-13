#
# The MaxLength extensions extends Input to provide a
# onMaxLength callback that will be triggered when the maxLength
# is reached.
#
module.exports = ->
  enabled: ->
    @props.onMaxLength? && @props.maxLength?

  apply: (props) ->
    props.onChange = do (original = props.onChange) =>
      (e) =>
        @props.onMaxLength e if e.target.value.length >= @props.maxLength
        original? e
