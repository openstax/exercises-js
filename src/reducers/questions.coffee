_ = require 'underscore'
Constants = require '../actions/constants'
Question = require './question'

INITIAL_STATE = [Question.INITIAL_STATE]

reducer = (state = INITIAL_STATE, {type: action, payload}) ->
  if action is Constants.EXERCISE_LOAD

    return []

  else if action is Constants.EXERCISE_LOADED
    return _.map payload.questions, (question) ->
      answers = _.map(question.answers, (answer) -> answer.id)
      _.extend({}, question, {answers})


  else if (action is Constants.UPDATE_QUESTION_STIMULUS or
  action is Constants.UPDATE_QUESTION_STEM or
  action is Constants.UPDATE_SOLUTION or
  action is Constants.ADD_ANSWER or
  action is Constants.REMOVE_ANSWER or
  action is Constants.MOVE_ANSWER or
  action is Constants.TOGGLE_MULTIPLE_CHOICE or
  action is Constants.TOGGLE_FREE_RESPONSE or
  action is Constants.TOGGLE_PRESERVE_ORDER)

    return _.map state, (question) ->
      Question.reducer(question, {payload, type: action})

  return state

module.exports = {reducer, INITIAL_STATE}
