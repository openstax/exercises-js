_ = require 'underscore'
Constants = require '../actions/constants'

AnswerReducer = (state = {}, {type: action, payload}) ->
  if state.id isnt payload?.id then return state

  if action is Constants.UPDATE_ANSWER_FEEDBACK
    return _.extend({}, state, {feedback_html: payload.feedback_html})
  else if action is Constants.UPDATE_ANSWER_CONTENT
    return _.extend({}, state, {content_html: payload.content_html})
  else if action is Constants.SET_CORRECT
    return _.extend({}, state, {correctness: "1.0"})
  else if action is Constants.SET_INCORRECT
    return _.extend({}, state, {correctness: "0.0"})

  return state


module.exports = AnswersReducer = (state = [], {type: action, payload}) ->
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
      AnswerReducer(answer, {payload, type: action})

  return state
