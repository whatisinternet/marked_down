{ div, input, a, li, ul, img, hr } = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "right-navigation"

  render: ->
    bem = new Bemmer(block: "nav")

    div
      style: height: "100vh"
      className: "col s12 m4 l2 grey darken-3 white-text",
      input
        type: 'file'
        id: 'openable-file'
        style: {display: 'none'}
        onChange: _.bind(@props.fileSelected, @),
      div {},
        ul {},
          li className: bem.with(element: "list-item"),
            ""
          li className: bem.with(element: "list-item"),
            ""
          li className: bem.with(element: "list-item"),
            "Your room code is: #{@props.authCode}"
          hr className: bem.with(element: "seperator")
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.openAttachment,
                "Open file"
          hr className: bem.with(element: "seperator")
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              id: 'dlCode',
              "Export Markdown"
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              id: 'dlHTML',
                "Export Body HTML"
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              id: 'dlHTMLWrapped',
                "Export Wrapped HTML"
          hr className: bem.with(element: "seperator")
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.vim,
                "Vim keybindings"
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.emacs,
                "eMacs keybindings"
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.sublime,
                "Sublime keybindings (Normal)"
          hr className: bem.with(element: "seperator")
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.toggleFullScreen,
                "FullScreen"
          hr className: bem.with(element: "seperator")
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.changeRooms,
                "Change Rooms"
          li className: bem.with(element: "list-item"),
            a
              className: bem.with(element: "link")
              onClick: @props.logout,
                "Logout"
