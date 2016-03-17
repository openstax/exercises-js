
React = require 'react'
_ = require 'underscore'
{connect} = require 'react-redux'

Attachment = require './attachment'
AttachmentChooser = require './attachment-chooser'

Attachments = React.createClass
  render:() ->
    <div className="attachments">
      { for attachment in @props.attachments
        <Attachment key={attachment.asset.url} exerciseUid={@props.id} attachment={attachment} /> }
      <AttachmentChooser exerciseUid={@props.id} />
    </div>

mapStateToProps = (state) -> _.extend({}, {attachments: state.attachments, id: state.exercise.uid})
module.exports = connect(mapStateToProps)(Attachments)
