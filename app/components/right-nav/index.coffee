{ div, input, a, li, ul, img, hr } = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "right-navigation"

  render: ->
    div className: "col s12 m4 l2",
      input
        type: 'file'
        id: 'openable-file'
        style: {display: 'none'}
        onChange: _.bind(@props.fileSelected, @),
      div className: 'card-panel blue-grey lighten-4 hoverable',
        ul {},
          li {},
            img
              style: width: '30px'
              className: "circle responsive-img",
              src: @props.user.photoURL
          li {},
            "Your room code is: #{@props.authCode}"
          hr {}
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.openAttachment,
                "Open file"
          hr {}
          li {},
            a id: 'dlCode',
              "Export Markdown"
          li {},
            a id: 'dlHTML',
              "Export Body HTML"
          li {},
            a id: 'dlHTMLWrapped',
              "ExportWrapped HTML"
          hr {}
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.vim,
                "Vim keybindings"
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.emacs,
                "eMacs keybindings"
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.sublime,
                "Sublime keybindings (Normal)"
          hr {}
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.toggleFullScreen,
                "FullScreen"
          hr {}
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.changeRooms,
                "Change Rooms"
          li {},
            a
              style: cursor: "pointer"
              onClick: @props.logout,
                "Logout"
