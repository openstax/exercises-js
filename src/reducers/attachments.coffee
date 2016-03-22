
Constants = require '../actions/constants'
INITIAL_STATE = []

reducer = (state = INITIAL_STATE, {type:action, payload}) ->

  if action is Constants.EXERCISE_LOAD
    return []
  else if action is Constants.EXERCISE_LOADED
    return payload.attachments
  else if action is Constants.UPLOADED_ATTACHMENT
    return state.concat(payload.attachment)
  else if action is Constants.DELETED_ATTACHMENT
    return state.filter((attachment) -> attachment.id isnt payload.id)

  return state


module.exports = {reducer, INITIAL_STATE}
