{div, ul, li, nav, a, input, i}  = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "nav::file::open"

  render: ->
    div {},
      input
        type: 'file'
        id: 'openable-file'
        style: {display: 'none'}
        onChange: _.bind(@props.fileSelected, @),
      ul
        id: "export-dropdown"
        className: 'dropdown-content',
          li {},
            a
              href: ''
              id: 'dlCode',
                "Code"
          li {},
            a
              href: ''
              id: 'dlHTML',
                "HTML"
          li {},
            a
              href: ''
              id: 'dlHTMLWrapped',
                "HTML wrapped"
