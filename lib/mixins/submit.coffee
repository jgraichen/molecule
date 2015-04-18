#
module.exports = (config) ->
  prepare: (props) ->
    if props.submitOnBlur?
      props.onBlur = do (original = props.onBlur) =>
        (event) =>
          @submit()
          original? event

  submit: ->
    return unless @props.onSubmit

    promise = @props.onSubmit @state.value
    return unless promise?

    promise
      .then =>
        @setState error: false, => @props.onError?(false)
      .catch (err) =>
        if err.message?
          @setState error: true, =>
            @refs['input'].getDOMNode().focus()
            @props.onError? err.message

    @refs['indicator']?.track promise

