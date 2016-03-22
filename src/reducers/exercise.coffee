_ = require 'underscore'
Constants = require '../actions/constants'

INITIAL_STATE =
  editors: []
  authors: []
  copyright_holders: []
  derived_from: []
  stimulus_html: ""
  questions: []
  published_at: null
  number: ""
  uid: ""

reducer = (state = INITIAL_STATE, {type: action, payload}) ->

  if (action is Constants.EXERCISE_LOAD or
  action is Constants.ERROR_LOAD_EXERCISE or
  action is Constants.ERROR_SAVE_EXERCISE or
  action is Constants.ERROR_PUBLISH_EXERCISE)

    return null

  else if (action is Constants.EXERCISE_LOADED or
  action is Constants.EXERCISE_SAVED or
  action is Constants.EXERCISE_PUBLISHED)

    return {
      uid: payload.uid
      number: payload.number
      questions: _.map(payload.questions, (question) -> question.id)
      published_at: payload.published_at
      stimulus_html: payload.stimulus_html
    }

  return state

module.exports = {reducer, INITIAL_STATE}
