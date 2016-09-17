{div}  = React.DOM

marked = require('marked')

module.exports = React.createFactory React.createClass
  displayName: "index::display"

  render: ->

    bem = new Bemmer(block: "preview")

    div
      className: bem.with(
        element: "column"
        classNames: "col #{@props.rightClass} white blue-grey-text text-darken-4"
      ),
      if @props.code?
        div dangerouslySetInnerHTML: __html: marked(@props.code)
