{div, ul, li, nav, a, input, i}  = React.DOM

ReactFireMixin = require('reactfire')

module.exports = React.createFactory React.createClass
  displayName: "nav::User"

  mixins: [
    ReactFireMixin
  ]

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
            onClick: @props.changeRooms,
              "change Rooms"
        li {},
          a
            onClick: @props.logout,
              "Logout"
