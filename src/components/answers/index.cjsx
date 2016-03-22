React = require 'react'
_ = require 'underscore'
{ Answer } = require './answer'

{contain} = require '../../containers/answers'

Answers = React.createClass
  renderAnswer:(answer, index) ->
    <Answer key={answer}
      questionId={@props.id}
      id={answer}
      canMoveUp={index isnt @props.answers.length - 1}
      canMoveDown={index isnt 0}/>

  render: ->
    <div>
      <label>Answers:</label>
      <a className="pull-right" onClick={@addAnswer}>Add New</a>
      <ol>{ _.map(@props.answers, @renderAnswer) }</ol>
    </div>

module.exports = { Answers: contain(Answers), Component: Answers }
