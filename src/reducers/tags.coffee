_ = require 'underscore'
Constants = require '../actions/constants'
Tags = require '../helpers/tags'

INITIAL_STATE =
  editable: [],
  fixed: []

module.exports = (state = INITIAL_STATE, {type:action, payload}) ->
  if action is Constants.EXERCISE_LOAD

    return INITIAL_STATE

  else if action is Constants.EXERCISE_LOADED

    return Tags.getTagTypes(payload.tags)

  else if action is Constants.UPDATE_FIXED_TAGS

    fixed = _.map state.fixed, (tag) ->
      if tag.base is payload.base
        _.extend(tag, {value: payload.value})
      else
        tag

    return _.extend({}, state, {fixed})

  else if action is Constants.UPDATE_EDITABLE_TAGS

    return _.extend({}, state, {editable: payload.tags})

  return state
