{div}  = React.DOM

marked = require('marked')

module.exports = React.createFactory React.createClass
  displayName: "index::display"

  render: ->
    div className: "col #{@props.rightClass}",
      div className: 'card-panel white blue-grey-text text-darken-4 hoverable',
      if @props.code?
        div dangerouslySetInnerHTML: __html: marked(@props.code)
