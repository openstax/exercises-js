
{ createAction } = require 'redux-actions'
Constants = require './constants'

updateStimulus = createAction(Constants.UPDATE_QUESTION_STIMULUS, (id, stimulus_html) ->
  {id, stimulus_html}
)
updateStem = createAction(Constants.UPDATE_QUESTION_STEM, (id, stem_html) ->
  {id, stem_html}
)
updateSolution = createAction(Constants.UPDATE_SOLUTION, (id, content_html) ->
  {id, content_html}
)
addAnswer = createAction(Constants.ADD_ANSWER, (id, newAnswerId) ->
  {id, newAnswerId}
)
removeAnswer = createAction(Constants.REMOVE_ANSWER, (id, answerId) ->
  {id, answerId}
)
moveAnswer = createAction(Constants.MOVE_ANSWER, (id, answerId, direction) ->
  {id, answerId, direction}
)
toggleMultipleChoiceFormat = createAction(Constants.TOGGLE_MULTIPLE_CHOICE, (id) ->
  {id}
)
toggleFreeResponseFormat = createAction(Constants.TOGGLE_FREE_RESPONSE, (id) ->
  {id}
)
togglePreserveOrder = createAction(Constants.TOGGLE_PRESERVE_ORDER, (id) ->
  {id}
)

module.exports = {
  updateStimulus,
  updateStem,
  updateSolution,
  addAnswer,
  removeAnswer,
  moveAnswer,
  toggleMultipleChoiceFormat,
  toggleFreeResponseFormat,
  togglePreserveOrder
}


