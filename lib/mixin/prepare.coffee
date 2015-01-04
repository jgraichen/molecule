# The Prepare mixin provides a helper function
# for preparing a render context and props needed in most
# components.
#
# It copies the components props into a new object to allow
# for modification, extract className into classList and
# back. Additionally it checks for extensions and apply
# them if appropriate.
#
module.exports = ->
  prepare: (fn) ->
    # Create new props object with empty
    # `className` and `classList`. This way we do not have
    # to check if `className` exists before splitting nor
    # if `classList` exists before adding elements.
    props = className: '', classList: [], children: []

    # Copy properties from components props into new props.
    props[key] = value for key, value of @props

    # Split given class names and add to the front of
    # `classList`. `className` should always be a `String` here.
    props.classList.unshift props.className.split(/\s+/)...

    # Apply extensions if appropriate.
    @applyExtensions? props, props.classList

    # Call given function for fine tuning props.
    fn? props, props.classList

    # Override `className` with classes from `classList`.
    # The `className` property should not be used in `fn`
    # not in extensions.
    props.className = props.classList.join(' ').trim()

    # Cleanup
    delete props.classList

    # Return props copy
    props
