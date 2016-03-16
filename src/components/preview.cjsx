React = require 'react'
_ = require 'underscore'
BS = require 'react-bootstrap'
classnames = require 'classnames'
{ connect } = require 'react-redux'

{buildExerciseFromState} = require '../helpers/exercise'
Question = require 'openstax-react-components/src/components/question'
ArbitraryHtml = require 'openstax-react-components/src/components/html'

Preview = React.createClass

  PropTypes:
    displayFeedback: React.PropTypes.bool
    panelStyle: React.PropTypes.string
    header:     React.PropTypes.element
    exercise:   React.PropTypes.shape(
      content: React.PropTypes.object
      tags:    React.PropTypes.array
    ).isRequired

  getDefaultProps: ->
    panelStyle: 'default'

  renderQuestions: (question) ->
    feedback_html = _.first(question.collaborator_solutions)?.content_html

    if feedback_html
      feedback = <ArbitraryHtml className="free-response" html={feedback_html} />

    <Question key={question.id} model={question} show_all_feedback={true}>
      {feedback}
    </Question>

  render: ->
    exercise = buildExerciseFromState(@props)
    questions = _.map(exercise.questions, @renderQuestions)

    <div>{questions}</div>

module.exports = connect((props) -> props)(Preview)
