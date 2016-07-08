require '../assets/styles/index'
require 'materialize-css/dist/css/materialize.css'
require 'materialize-css/dist/js/materialize.min.js'
require "codemirror/theme/material.css"

App = require("./application.coffee")

document.addEventListener "DOMContentLoaded", (e) ->
  ReactDOM.render(
    App()
    document.getElementById('appEntry')
  )
