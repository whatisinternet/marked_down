
module.exports =
  vim: ->
    localStorage.setItem("markedDownKeyBinding", 'vim')
    @setState keyBinding: 'vim'

  emacs: ->
    localStorage.setItem("markedDownKeyBinding", 'emacs')
    @setState keyBinding: 'emacs'

  sublime: ->
    localStorage.setItem("markedDownKeyBinding", 'sublime')
    @setState keyBinding: 'sublime'
