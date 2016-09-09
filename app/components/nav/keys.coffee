{div, ul, li, nav, a, input, i}  = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "nav::keys"

  render: ->
    ul
      id: "code-type-dropdown"
      className: 'dropdown-content',
        li {},
          a
            onClick: @props.vim,
              "VIM"
        li {},
          a
            onClick: @props.emacs,
              "Emacs"
        li {},
          a
            onClick: @props.sublime,
              "Sublime"
