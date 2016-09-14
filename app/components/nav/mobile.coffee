{div, ul, li, nav, a, input, i, img}  = React.DOM

navigate = require('react-mini-router').navigate
Users = require("./users.coffee")

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
          Users
            active_users: @props.active_users
          ul
            id: "nav-mobile"
            className: "right",
              li {},
                a
                  className: 'dropdown-button'
                  'data-activates': "user-dropdown",
                    div style: display: "inline-block",
                      "Your room code is: #{@props.authCode}"
                    div style: display: "inline-block",
                      img
                        className: "circle responsive-img"
                        style: width: '30px', paddingTop: '15px'
                        src: @props.user.photoURL
