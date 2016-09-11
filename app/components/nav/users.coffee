{div, img}  = React.DOM


module.exports = React.createFactory React.createClass
  displayName: "nav::Users"

  render: ->
    div
      style:
        position: 'fixed'
        bottom: '10px'
        right: '20px'
        height: '30px'
        backgroundColor: 'rgba(0,0,0,0.6)'
        borderRadius: '5px'
      className: 'white-text',
        _.map @props.active_users, (user) ->
          div
            style:
              paddingLeft: '5px'
            key: user.uid,
              img
                className: "circle responsive-img"
                style:
                  marginBottom: '12px'
                  marginRight: '3px'
                  width: '20px',
                src: user.photo
                alt: user.email
