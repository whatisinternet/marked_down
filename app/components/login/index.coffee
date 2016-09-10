{div, input, label, h1}  = React.DOM

navigate = require('react-mini-router').navigate
uuid = require('uuid-v4')

module.exports = React.createFactory React.createClass
  displayName: "login"

  getInitialState: ->
    user: btoa(JSON.stringify(@props.user))
    newDocument: true
    documentEnabled: true
    docCode: ""

  newRoute: ->
    date = new Date()
    window
      .btoa(
        uuid() + uuid()
      )[0..10]

  existingDocument: ->
    @setState newDocument: !@state.newDocument

  docCode: (e) ->
    docCode = e.target.value
    @setState docCode: docCode

  navigateNewRoute: ->
    navigate "/#{@newRoute()}/#{@state.user}"

  render: ->
    div
      className: "grey darken-3"
      style:
        display: "flex"
        alignItems: "center"
        justifyContent: "center"
        height: "100vh",
      div className: "row center-align white-text",
        div className: "row",
          div
            className: "row"
            style: if @state.newDocument then {display: "none"} else {display: ""},
            div className: "input-field",
              input
                onKeyUp: @docCode
                type: "text"
                id: "docCode"
              label
                htmlFor: "docCode",
                  "Room code"
          div className: "row",
            div className: "col s6",
              div
                onClick: _.partial navigate, "/#{@state.docCode}/#{@state.user}"
                style: if @state.newDocument || !@state.documentEnabled then {display: "none"} else {display: ""}
                className: "btn-flat yellow",
                  "Open"
            div className: "col s6",
              div
                onClick: _.partial @existingDocument
                style: if @state.newDocument then {display: "none"} else {display: ""}
                className: "btn-flat yellow",
                  "Cancel"
            if @state.newDocument && @state.documentEnabled
              div {},
                div
                  className: "row center-align",
                  div className: "col s12",
                    div
                      onClick: _.partial @navigateNewRoute
                      style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                      className: "btn-flat yellow",
                        "New Document"
                div
                  className: "row center-align",
                  div className: "col s12",
                    div
                      onClick: _.partial @existingDocument
                      style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                      className: "btn-flat yellow accent-2",
                        "Existing Document"
