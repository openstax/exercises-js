React = require 'react'
_ = require 'underscore'
{ connect } = require 'react-redux'

Answer = require './answer'
QuestionHelper = require '../helpers/question'
QuestionActions = require '../actions/question'
AnswerActions = require '../actions/answer'

Question = React.createClass
  displayName: 'Question'

  getInitialState: -> {}

  changeAnswer: (answerId) ->
    @props.dispatch(AnswerActions.setCorrect(answerId))
    @props.dispatch(AnswerActions.setIncorrect(@props.correctAnswerId))

  updateStimulus: (event) ->
    @props.dispatch(QuestionActions.updateStimulus(@props.id, event.target?.value))

  updateStem: (event) ->
    @props.dispatch(QuestionActions.updateStem(@props.id, event.target?.value))

  updateSolution: (event) ->
    @props.dispatch(QuestionActions.updateSolution(@props.id, event.target?.value))

  addAnswer: ->
    @props.dispatch(QuestionActions.addAnswer(@props.id, QuestionHelper.newAnswerId()))

  removeAnswer:(answerId) ->
    @props.dispatch(QuestionActions.removeAnswer(@props.id, answerId))

  moveAnswer: (answerId, direction) ->
    @props.dispatch(QuestionActions.moveAnswer(@props.id, answerId, direction))

  multipleChoiceClicked: (event) ->
    @props.dispatch(QuestionActions.toggleMultipleChoiceFormat(@props.id))

  freeResponseClicked: (event) ->
    @props.dispatch(QuestionActions.toggleFreeResponseFormat(@props.id))

  preserveOrderClicked: (event) ->
    @props.dispatch(QuestionActions.togglePreserveOrder(@props.id))

  render: ->
    {id} = @props
    answers = []

    for answer, index in @props.answers
      answers.push(<Answer key={answer}
        sync={@props.sync}
        id={answer}
        canMoveUp={index isnt @props.answers.length - 1}
        canMoveDown={index isnt 0}
        moveAnswer={@moveAnswer}
        removeAnswer={@removeAnswer}
        changeAnswer={@changeAnswer}/>)

    <div>
      <div>
        <label>Question Stem</label>
        <textarea onChange={@updateStem} defaultValue={@props.stem_html}></textarea>
      </div>
      <div>
        <label>Question Stimulus</label>
        <textarea onChange={@updateStimulus} defaultValue={@props.stimulus_html}></textarea>
      </div>
      <div>
        <label>Question Formats</label>
      </div>
      <div>
        <input onChange={@multipleChoiceClicked}
          id="multipleChoiceFormat#{id}"
          type="checkbox"
          defaultChecked={QuestionHelper.isMultipleChoice(@props)} />
        <label htmlFor="multipleChoiceFormat#{id}">Multiple Choice</label>
      </div>
      <div>
        <input onChange={@freeResponseClicked}
          id="freeResponseFormat#{id}"
          type="checkbox"
          defaultChecked={QuestionHelper.isFreeResponse(@props)} />
        <label htmlFor="freeResponseFormat#{id}">Free Response</label>
      </div>
      <div>
        <label>Detailed Solution</label>
        <textarea onChange={@updateSolution}
          defaultValue={QuestionHelper.getSolution(@props)}>
        </textarea>
      </div>
      <div>
        <label>
          Answers:
        </label>
        <a className="pull-right" onClick={@addAnswer}>Add New</a>
        <p>
          <input onChange={@preserveOrderClicked}
            id="preserveOrder#{id}"
            type="checkbox"
            defaultChecked={@props.is_answer_order_important} />
          <label htmlFor="preserveOrder#{id}">Preserve Answer Orders</label>
        </p>
        <ol>
          {answers}
        </ol>
      </div>
    </div>

mapStateToProps = (state, props) ->
  question = _.findWhere(state.questions, {id: props.id})
  answers = _.map(question.answers, (answer) ->
    _.findWhere(state.answers, {id: answer}))

  correctAnswer = _.findWhere(answers, {correctness: "1.0"})

  _.extend({}, question, {correctAnswerId: correctAnswer?.id})

module.exports = connect(mapStateToProps)(Question)
