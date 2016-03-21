React = require 'react'
_ = require 'underscore'

{ Question } = require './question'
{ contain } = require '../../containers/questions'

Questions = React.createClass
  renderQuestion: (question) ->
    <Question key={question.id} id={question.id} />

  render: ->
    <div>
      <label>Questions</label>
      <ol className="questions">
        { _.map(@props.questions, @renderQuestion) }
      </ol>
    </div>

module.exports = { Questions: contain(Questions), Component: Questions }
