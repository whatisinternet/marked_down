{div, ul, li, nav, a, input, i}  = React.DOM

module.exports = React.createFactory React.createClass
  displayName: "nav::keys"

  render: ->
    ul
      id: "code-type-dropdown"
      className: 'dropdown-content',
        li {},
          a
            href: ''
            onClick: @props.vim,
              "VIM"
        li {},
          a
            href: ''
            onClick: @props.emacs,
              "Emacs"
        li {},
          a
            href: ''
            onClick: @props.sublime,
              "Sublime"
