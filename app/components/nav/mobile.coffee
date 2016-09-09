{div, ul, li, nav, a, input, i}  = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "nav::mobile"

  render: ->
    div className: 'navbar-fixed',
      nav className: 'grey darken-4',
        div className: "nav-wrapper",
          ul
            id: "nav-mobile"
            className: "left",
              li {},
                a
                  onClick: @props.openAttachment,
                    "Open File"
              li {},
                a
                  className: 'dropdown-button'
                  'data-activates': "export-dropdown",
                      "Export"
              li {},
                a
                  className: 'dropdown-button'
                  'data-activates': "code-type-dropdown",
                      "Key bindings"
          ul
            id: "nav-mobile"
            className: "right",
              li {},
                "Your room code is: #{@props.authCode}"
              li {},
                a
                  onClick: @props.toggleFullScreen
                  href: '',
                    "Toggle Fullscreen"
