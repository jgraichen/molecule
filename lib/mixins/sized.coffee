#
_size = (props) ->
  switch props.size
    when 'shortest', 'shorter', 'short', 'default', 'long', 'longer', 'fluid', 'default'
      do (size = props.size) =>
        delete props.size
        props.classList.push "m-#{size}"

module.exports = ->
  prepare: (props) ->
    _size props
