#
# The MaxLength extensions extends Input to provide a
# onMaxLength callback that will be triggered when the maxLength
# is reached.
#
module.exports = ->
  prepare: (props) ->
    return unless props.onMaxLength? && props.maxLength?

    props.onChange = do (original = props.onChange) =>
      (e) =>
        props.onMaxLength e if e.target.value.length >= props.maxLength
        original? e
