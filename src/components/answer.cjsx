React = require 'react'
_ = require 'underscore'
{ connect } = require 'react-redux'
Actions = require '../actions/answer'
AnswerHelper = require '../helpers/answer'

Answer = React.createClass
  displayName: 'Answer'

  getInitialState: -> {}

  updateContent: (event) ->
    @props.dispatch(Actions.updateContent(@props.id, event.target?.value))

  changeCorrect: (event) ->
    @props.changeAnswer(@props.id)

  updateFeedback: (event) ->
    @props.dispatch(Actions.updateFeedback(@props.id, event.target?.value))

  render: ->
    moveUp = <a className="pull-right" onClick={_.partial(@props.moveAnswer, @props.id, 1)}>
      <i className="fa fa-arrow-circle-down"/>
    </a> if @props.canMoveUp

    moveDown = <a className="pull-right" onClick={_.partial(@props.moveAnswer, @props.id, -1)}>
      <i className="fa fa-arrow-circle-up" />
    </a> if @props.canMoveDown

    correctClassname = 'correct-answer' if AnswerHelper.isCorrect(@props)

    <li className={correctClassname}>
      <p>
        <span className="answer-actions">
          <a className="pull-right" onClick={_.partial(@props.removeAnswer, @props.id)}>
            <i className="fa fa-ban" />
          </a>
          {moveUp}
          {moveDown}
          <a className="pull-right is-correct #{correctClassname}" onClick={@changeCorrect}>
            <i className="fa fa-check-circle-o" />
          </a>
        </span>
      </p>
      <label>Answer Content</label>
      <textarea onChange={@updateContent} defaultValue={@props.content_html}>
      </textarea>
      <label>Answer Feedback</label>
      <textarea onChange={@updateFeedback} defaultValue={@props.feedback_html}>
      </textarea>
    </li>

mapStateToProps = (state, props) ->
  _.findWhere(state.answers, {id: props.id}) or {}

module.exports = connect(mapStateToProps)(Answer)
