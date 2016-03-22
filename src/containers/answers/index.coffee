_ = require 'underscore'
{ connect } = require 'react-redux'

mapper = (state, props) ->
  question = _.findWhere(state.questions, {id: props.id}) or {}
  answers: question.answers

contain = _.partial(connect(mapper))

module.exports = { mapper, contain }
