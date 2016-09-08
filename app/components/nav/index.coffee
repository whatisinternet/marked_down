{div, ul, li, nav, a, input, i}  = React.DOM

Open = require("./file_open.coffee")
Keys = require("./keys.coffee")
Mobile = require("./mobile.coffee")

module.exports = React.createFactory React.createClass
  displayName: "nav"

  render: ->
    div {},
      Open
        fileSelected: @props.fileSelected
      Keys
        vim: @props.vim
        emacs: @props.emacs
        sublime: @props.sublime
      Mobile
        openAttachment: @props.openAttachment
        toggleFullScreen: @props.toggleFullScreen
        authCode: @props.authCode

