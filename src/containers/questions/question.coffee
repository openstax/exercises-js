_ = require 'underscore'
{ connect } = require 'react-redux'

mapper = (state, props) ->
  question = _.findWhere(state.questions, {id: props.id})
  answers = _.map(question.answers, (answer) ->
    _.findWhere(state.answers, {id: answer}))

  correctAnswer = _.findWhere(answers, {correctness: "1.0"})

  _.extend({}, question, {correctAnswerId: correctAnswer?.id})

contain = _.partial(connect(mapper))

module.exports = { contain, mapper }
