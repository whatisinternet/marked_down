{div, ul, li, nav, a, input, i}  = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "nav::User"

  render: ->
    ul
      id: "user-dropdown"
      className: 'dropdown-content',
        li {},
          a
            onClick: @props.toggleFullScreen,
              "Fullscreen"
        li {},
          a
            onClick: @props.logout,
              "Logout"
