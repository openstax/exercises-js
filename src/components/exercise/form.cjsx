
React = require 'react'
ExerciseTags= require '../tags'
{ Questions } = require '../questions'
{ PublishButton } = require './publish-button'

{ contain } = require '../../containers/exercise'
{ Actions } = require '../../actions/exercise'

AsyncButton = require 'openstax-react-components/src/components/buttons/async-button.cjsx'

Form = React.createClass
  saveExercise: ->
    if confirm('Are you sure you want to save?')
      @props.dispatch(Actions.save(@getId()))

  updateStimulus: (event) ->
    Actions.updateStimulus(@getId(), event.target?.value)

  render: ->
    if @props.exercise.published_at then return null

    isWorking = @props.viewState.saving or @props.viewState.publishing
    <form>
      <div>
        <label>Exercise Number</label>: {@props.exercise.number}
      </div><div>
        <label>Exercise Stimulus</label>
        <textarea onChange={@updateStimulus} defaultValue={@props.exercise.stimulus_html}>
        </textarea>
      </div>
      <Questions />
      <ExerciseTags id={@props.id} />
      <AsyncButton
        bsStyle='info'
        onClick={@saveExercise}
        disabled={isWorking}
        isWaiting={@props.viewState.saving}
        waitingText='Saving...'
        isFailed={@props.viewState.failed}>
        Save
      </AsyncButton>
      <PublishButton />
    </form>


module.exports = {Form: contain(Form), Component: Form}
