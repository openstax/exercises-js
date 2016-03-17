# @csx React.DOM
React = require 'react'
_ = require 'underscore'
{connect} = require 'react-redux'

BS = require 'react-bootstrap'
Question = require './question'
Preview = require './preview'
ExerciseTags = require './tags'
Attachments = require './attachments'
{ArbitraryHtmlAndMath} = require 'openstax-react-components'
AsyncButton = require 'openstax-react-components/src/components/buttons/async-button.cjsx'
{Actions} = require '../actions/exercise'

Exercise = React.createClass
  displayName: 'Exercise'

  componentWillMount: -> @props.dispatch(Actions.load(@props.id))

  updateStimulus: (event) -> Actions.updateStimulus(@getId(), event.target?.value)

  getId: -> @props.id

  getDraftId: (id) ->
    draftId = if id.indexOf("@") is -1 then id else id.split("@")[0]
    "#{draftId}@d"

  saveExercise: ->
    if confirm('Are you sure you want to save?')
      @props.dispatch(Actions.save(@getId()))

  publishExercise: ->
    if confirm('Are you sure you want to publish?')
      @props.dispatch(Actions.save(@getId()))
      @props.dispatch(Actions.publish(@getId()))

  renderLoading: ->
    <div>Loading exercise: {@getId()}</div>

  renderFailed: ->
    <div>Failed loading exercise, please check id</div>

  renderForm: ->
    id = @getId()

    questions = []
    for question in @props.exercise.questions
      questions.push(<Question key={question} sync={@sync} id={question} />)

    isWorking = @props.viewState.saving or @props.viewState.publishing

    if not @props.exercise.published_at
      publishButton = <AsyncButton
        bsStyle='primary'
        onClick={@publishExercise}
        disabled={isWorking}
        isWaiting={@props.viewState.publishing}
        waitingText='Publishing...'
        isFailed={@props.viewState.failed}
        >
        Publish
      </AsyncButton>

    <div>
      <div>
        <label>Exercise Number</label>: {@props.exercise.number}
      </div><div>
        <label>Exercise Stimulus</label>
        <textarea onChange={@updateStimulus} defaultValue={@props.exercise.stimulus_html}>
        </textarea>
      </div>
      {questions}
      <ExerciseTags id={id} />
      <AsyncButton
        bsStyle='info'
        onClick={@saveExercise}
        disabled={isWorking}
        isWaiting={@props.viewState.saving}
        waitingText='Saving...'
        isFailed={@props.viewState.failed}
        >
        Save
      </AsyncButton>
      {publishButton}
    </div>

  render: ->
    id = @getId()
    if not @props.exercise and not @props.viewState.failed
      return @renderLoading()
    else if @props.viewState.failed
      return @renderFailed()

    exercise = @props.exercise
    exerciseUid = exercise.uid

    preview = <Preview />

    if exercise.published_at
      publishedLabel =
        <div>
          <label>Published: {exercise.published_at}</label>
        </div>
      editLink =
        <div>
          <a href="/exercise/#{@getDraftId(id)}">Edit Exercise</a>
        </div>
    else
      form = @renderForm(id)

    <BS.Grid>
      <Attachments />

      <BS.Row><BS.Col xs={5} className="exercise-editor">
        <div>
          <label>Exercise ID:</label> {exerciseUid}
        </div>
        {publishedLabel}
        {editLink}
        <form>{form}</form>
      </BS.Col><BS.Col xs={6} className="pull-right">
        {preview}
      </BS.Col></BS.Row>
    </BS.Grid>

mapStateToProps = (state) ->
  return _.extend({}, state, {
    id: state.viewState?.id
  })

module.exports = connect(mapStateToProps)(Exercise)
