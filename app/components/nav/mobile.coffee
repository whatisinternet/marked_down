{div, ul, li, nav, a, input, i, img}  = React.DOM

navigate = require('react-mini-router').navigate

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
                  className: 'dropdown-button'
                  'data-activates': "user-dropdown",
                    img
                      className: "circle responsive-img"
                      style: width: '30px', paddingTop: '15px'
                      src: @props.user.photoURL
