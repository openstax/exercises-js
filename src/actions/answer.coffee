{ createAction } = require 'redux-actions'
Constants = require './constants'

updateFeedback = createAction(Constants.UPDATE_ANSWER_FEEDBACK, (id, feedback_html) ->
  {id, feedback_html}
)
updateContent = createAction(Constants.UPDATE_ANSWER_CONTENT, (id, content_html) ->
  {id, content_html}
)

setIncorrect = createAction(Constants.SET_INCORRECT, (id) -> {id})
setCorrect = createAction(Constants.SET_CORRECT, (id) -> {id})

module.exports = {updateFeedback, updateContent, setIncorrect, setCorrect}
