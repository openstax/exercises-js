
_ = require 'underscore'
Constants = require '../actions/constants'
path = window.location.pathname.split("/")

INITIAL_STATE =
  loading: true
  saving: false
  publishing: false
  failed: false
  error: null
  id: if path.length > 2 then path[2] else prompt('Enter exercise id')

reducer = (state = {}, {type:action, payload}) ->
  if action is Constants.EXERCISE_LOAD
    return _.extend({}, state, loading: true, failed: false)
  else if action is Constants.EXERCISE_LOADED
    return _.extend({}, state, loading: false, failed: false)
  else if action is Constants.ERROR_LOAD_EXERCISE
    return _.extend({}, state, loading: false, failed: true, error: payload )

  return state
module.exports = {reducer, INITIAL_STATE}
