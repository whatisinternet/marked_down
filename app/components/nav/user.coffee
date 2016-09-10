{div, ul, li, nav, a, input, i}  = React.DOM

navigate = require('react-mini-router').navigate
ReactFireMixin = require('reactfire')

module.exports = React.createFactory React.createClass
  displayName: "nav::User"

  changeRooms: ->
    try
      @unbind('code')
    localStorage.setItem( "doc", "")
    navigate "/#{btoa(JSON.stringify(@props.user))}", true


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
            onClick: @changeRooms,
              "change Rooms"
        li {},
          a
            onClick: @props.logout,
              "Logout"
