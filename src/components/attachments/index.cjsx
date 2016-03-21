
React = require 'react'
_ = require 'underscore'
{connect} = require 'react-redux'

Attachment = require './attachment'
AttachmentChooser = require './attachment-chooser'

Attachments = React.createClass
  render: ->
    {id, attachments} = @props
    <div className="attachments">
      { _.map attachments, (attachment) ->
        <Attachment key={attachment.asset.url} exerciseUid={id} attachment={attachment} />
      }
      <AttachmentChooser exerciseUid={id} />
    </div>

mapStateToProps = (state) ->
  _.extend({}, {attachments: state.attachments, id: state.exercise?.uid})
module.exports = connect(mapStateToProps)(Attachments)
