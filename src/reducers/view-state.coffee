
_ = require 'underscore'
Constants = require '../actions/constants'

module.exports = (state = {}, {type:action, payload}) ->
  if action is Constants.EXERCISE_LOAD
    return _.extend({}, state, loading: true, failed: false)
  else if action is Constants.EXERCISE_LOADED
    return _.extend({}, state, loading: false, failed: false)
  else if action is Constants.ERROR_LOAD_EXERCISE
    return _.extend({}, state, loading: false, failed: true, error: payload )

  return state

