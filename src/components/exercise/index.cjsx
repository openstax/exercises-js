# @csx React.DOM
React = require 'react'
_ = require 'underscore'

BS = require 'react-bootstrap'
{ contain } = require '../../containers/exercise'
{ Actions } = require '../../actions/exercise'

{ Preview } = require '../preview'
{ Form } = require './form'
Attachments = require '../attachments'
PublishedLabel = require './published-label'

Exercise = React.createClass
  displayName: 'Exercise'

  componentWillMount: -> @props.dispatch(Actions.load(@props.id))

  getId: -> @props.id

  getDraftId: ->
    { id } = @props
    draftId = if id.indexOf("@") is -1 then id else id.split("@")[0]
    "#{draftId}@d"

  renderLoading: ->
    <div className="loading">Loading exercise: {@getId()}</div>

  renderFailed: ->
    <div className="failed">Failed loading exercise, please check id</div>

  render: ->
    id = @getId()
    if @props.viewState.loading or not @props.exercise and not @props.viewState.failed
      return @renderLoading()
    else if @props.viewState.failed
      return @renderFailed()

    <BS.Grid>
      <Attachments />
      <BS.Row>
        <BS.Col xs={5} className="exercise-editor">
          <PublishedLabel id={@getDraftId()}
            uid={@props.exercise.uid}
            publishedAt={@props.exercise.published_at} />
          <Form />
        </BS.Col>
        <BS.Col xs={6} className="pull-right">
          <Preview />
        </BS.Col>
       </BS.Row>
    </BS.Grid>

module.exports = {Exercise : contain(Exercise), Component: Exercise}
