
React = require 'react'
{ Actions } = require '../../actions/exercise'
{ contain } = require '../../containers/exercise'
AsyncButton = require 'openstax-react-components/src/components/buttons/async-button.cjsx'

PublishButton = React.createClass
  publishExercise: ->
    if confirm('Are you sure you want to publish?')
      @props.dispatch(Actions.save(@getId()))
      @props.dispatch(Actions.publish(@getId()))

  render: ->
    isWorking = @props.viewState.saving or @props.viewState.publishing

    if not @props.exercise.published_at
      <AsyncButton
        bsStyle='primary'
        onClick={@publishExercise}
        disabled={isWorking}
        isWaiting={@props.viewState.publishing}
        waitingText='Publishing...'
        isFailed={@props.viewState.failed}>
        Publish
      </AsyncButton>

module.exports = {PublishButton: contain(PublishButton), Component: PublishButton}
