React = require 'react'
_ = require 'underscore'

{ contain } = require '../../containers/questions/question'
{ Answers } = require '../answers'

QuestionHelper = require '../../helpers/question'
QuestionActions = require '../../actions/question'
AnswerActions = require '../../actions/answer'

Question = React.createClass
  displayName: 'Question'

  getInitialState: -> {}

  updateStimulus: (event) ->
    @props.dispatch(QuestionActions.updateStimulus(@props.id, event.target?.value))

  updateStem: (event) ->
    @props.dispatch(QuestionActions.updateStem(@props.id, event.target?.value))

  updateSolution: (event) ->
    @props.dispatch(QuestionActions.updateSolution(@props.id, event.target?.value))

  multipleChoiceClicked: (event) ->
    @props.dispatch(QuestionActions.toggleMultipleChoiceFormat(@props.id))

  freeResponseClicked: (event) ->
    @props.dispatch(QuestionActions.toggleFreeResponseFormat(@props.id))

  preserveOrderClicked: (event) ->
    @props.dispatch(QuestionActions.togglePreserveOrder(@props.id))

  render: ->
    {id} = @props

    <li>
      <div>
        <label>Question Stem</label>
        <textarea onChange={@updateStem} defaultValue={@props.stem_html} />
      </div>
      <div>
        <label>Question Stimulus</label>
        <textarea onChange={@updateStimulus} defaultValue={@props.stimulus_html} />
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
          defaultValue={QuestionHelper.getSolution(@props)} />
      </div>
      <div>
        <p>
          <input type="checkbox" id="preserveOrder#{id}"
            onChange={@preserveOrderClicked}
            defaultChecked={@props.is_answer_order_important} />

          <label htmlFor="preserveOrder#{id}">Preserve Answer Orders</label>
        </p>
        <Answers id={id} questionId={id} answers={@props.answers} correctAnswerId={@props.correctAnswerId} />
      </div>
    </li>

module.exports = { Question: contain(Question), Component: Question }
