React = require 'react'
_ = require 'underscore'
{ contain } = require '../../containers/answers/answer'
ActionIcons = require './actions'
Actions = require '../../actions/answer'
AnswerHelper = require '../../helpers/answer'

Answer = React.createClass
  displayName: 'Answer'

  getInitialState: -> {}

  updateContent: (event) ->
    @props.dispatch(Actions.updateContent(@props.id, event.target?.value))

  updateFeedback: (event) ->
    @props.dispatch(Actions.updateFeedback(@props.id, event.target?.value))

  render: ->
    correctClassname = 'correct-answer' if AnswerHelper.isCorrect(@props)

    <li className="#{correctClassname}">
      <ActionIcons {...@props} />
      <label>Answer Content</label>
      <textarea onChange={@updateContent} defaultValue={@props.content_html} />
      <label>Answer Feedback</label>
      <textarea onChange={@updateFeedback} defaultValue={@props.feedback_html} />
    </li>

module.exports = { Answer: contain(Answer), Component: Answer }
