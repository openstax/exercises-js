_ = require 'underscore'
Constants = require '../actions/constants'

INITIAL_STATE =
  content_html: ""
  feedback_html: ""
  correctness: "1.0"

reducer = (state = {}, {type: action, payload}) ->
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

module.exports = {reducer, INITIAL_STATE}
