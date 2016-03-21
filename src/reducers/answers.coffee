_ = require 'underscore'
Constants = require '../actions/constants'
Answer = require './answer'

INITIAL_STATE = [Answer.INITIAL_STATE]

reducer = (state = INITIAL_STATE, {type: action, payload}) ->
  if action is Constants.EXERCISE_LOAD
    return []

  else if (action is Constants.EXERCISE_LOADED)
    return _.chain(payload.questions)
    .map((question) -> return question.answers)
    .flatten()
    .value()

  else if (action is Constants.ADD_ANSWER)
    return state.concat([
      id: payload.newAnswerId
      content_html: ''
      correctness: "0.0"
    ])

  else if (action is Constants.REMOVE_ANSWER)
    return state.filter((answer) -> return answer.id isnt payload.answerId)

  else if (action is Constants.UPDATE_ANSWER_FEEDBACK or
  action is Constants.UPDATE_ANSWER_CONTENT or
  action is Constants.SET_INCORRECT or
  action is Constants.SET_CORRECT)

    return _.map state, (answer) ->
      Answer.reducer(answer, {payload, type: action})

  return state

module.exports = {reducer, INITIAL_STATE}
