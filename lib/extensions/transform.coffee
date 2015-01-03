#
# The Transform extension uses a transform prop function to
# transform the entered value continuously.
#
module.exports =
  enabled: ->
    @props.transform?

  apply: (props) ->
    props.onChange = do (original = props.onChange) =>
      (e) =>
        e.target.value = @props.transform e.target.value
        original? e
