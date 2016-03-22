
_ = require 'underscore'
React = require 'react'
AnswerHelper = require '../../helpers/answer'

ActionIcons = React.createClass

  changeCorrect: -> @props.changeAnswer(@props.id)

  changeAnswer: ->
    @props.dispatch(AnswerActions.setCorrect(@props.id))
    @props.dispatch(AnswerActions.setIncorrect(@props.correctAnswerId))

  addAnswer: ->
    @props.dispatch(QuestionActions.addAnswer(@props.questionId, QuestionHelper.newAnswerId()))

  removeAnswer: ->
    @props.dispatch(QuestionActions.removeAnswer(@props.questionId, @props.id))

  moveAnswer: (direction) ->
    @props.dispatch(QuestionActions.moveAnswer(@props.questionId, @props.id, direction))

  render: ->
    moveUp = <a className="pull-right move-up" onClick={_.partial(@moveAnswer, 1)}>
      <i className="fa fa-arrow-circle-down"/>
    </a> if @props.canMoveUp

    moveDown = <a className="pull-right move-down" onClick={_.partial(@moveAnswer, -1)}>
      <i className="fa fa-arrow-circle-up" />
    </a> if @props.canMoveDown

    correctClassname = 'correct-answer' if AnswerHelper.isCorrect(@props)

    <p>
      <span className="answer-actions">
        <a className="pull-right" onClick={@removeAnswer}>
          <i className="fa fa-ban" />
        </a>
        {moveUp}
        {moveDown}
        <a className="pull-right is-correct #{correctClassname}" onClick={@changeAnswer}>
          <i className="fa fa-check-circle-o" />
        </a>
      </span>
    </p>

module.exports = ActionIcons
