{div, input, label, h1}  = React.DOM

navigate = require('react-mini-router').navigate

module.exports = React.createFactory React.createClass
  displayName: "login"

  getInitialState: ->
    userName: ""
    newDocument: true
    documentEnabled: false
    docCode: ""

  newRoute: ->
    date = new Date()
    window.btoa(date.toISOString)[0..10]

  updateUserName: (e) ->
    userName = e.target.value
    @setState
      userName: userName
      documentEnabled: if userName.length > 0 then true else false

  existingDocument: ->
    @setState newDocument: !@state.newDocument

  docCode: (e) ->
    docCode = e.target.value
    @setState docCode: docCode

  render: ->
    div {},
      div className: "row center-align white-text",
        h1 {},
          "Please login"
      div className: "row",
        div className: "col m8 l6 s12 offset-m2 offset-l3",
          div className: "card-panel blue-grey darken-4 white-text",
            div className: "row",
              div className: "input-field",
                input
                  onKeyUp: @updateUserName
                  type: "text"
                  id: "userName"
                label
                  htmlFor: "userName",
                    "User name"
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
                  onClick: _.partial navigate, "/#{@state.docCode}/#{@state.userName}"
                  style: if @state.newDocument || !@state.documentEnabled then {display: "none"} else {display: ""}
                  className: "btn-flat yellow",
                    "Open Document"
              div className: "col s6",
                div
                  onClick: _.partial @existingDocument
                  style: if @state.newDocument then {display: "none"} else {display: ""}
                  className: "btn-flat yellow",
                    "Cancel"
              div className: "col s6",
                div
                  onClick: _.partial @existingDocument
                  style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                  className: "btn-flat blue accent-2",
                    "Existing Document"
              div className: "col s6",
                div
                  onClick: _.partial navigate, "/#{@newRoute()}/#{@state.userName}"
                  style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                  className: "btn-flat yellow",
                    "New Document"
