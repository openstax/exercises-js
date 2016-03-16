React = require 'react'
BS = require 'react-bootstrap'
classnames = require 'classnames'
{connect} = require 'react-redux'
{remove} = require '../actions/attachments'

Attachment = React.createClass

  propTypes:
    exerciseUid: React.PropTypes.string.isRequired
    attachment: React.PropTypes.shape({
      asset: React.PropTypes.shape({
        url: React.PropTypes.string.isRequired
        large: React.PropTypes.shape( url: React.PropTypes.string.isRequired ).isRequired
        medium: React.PropTypes.shape( url: React.PropTypes.string.isRequired ).isRequired
        small: React.PropTypes.shape( url: React.PropTypes.string.isRequired ).isRequired
      }).isRequired
    }).isRequired

  deleteImage: ->
    @props.dispatch(remove(@props.exerciseUid, @props.attachment.id))

  render: ->
    # large.url will be null on non-image assets (like PDF)
    url = @props.attachment.asset.large?.url or @props.attachment.asset.url
    copypaste = """
      <img src="#{url}" alt="">
    """
    <div className='attachment with-image'>
      <img className="preview" src={@props.attachment.asset.url} />
      <div className="controls">
        <BS.Button onClick={@deleteImage}>Delete</BS.Button>
      </div>
      <textarea value={copypaste} readOnly className="copypaste" />
    </div>

module.exports = connect()(Attachment)


