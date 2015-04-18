#
module.exports = (config) ->
  prepare: (props) ->
    if props.submitOnBlur?
      props.onBlur = do (original = props.onBlur) =>
        (event) =>
          @submit()
          original? event

    if @state.error
      props.classList.push 'm-error'

  submit: ->
    return unless @props.onSubmit

    promise = @props.onSubmit @state.value
    return unless promise?

    promise
      .then =>
        @setState error: false, =>
          @props.onError?(false)
      .catch (err) =>
        @setState error: true, =>
          @props.onError? err.message, err

    @refs['indicator']?.track promise

