_ = require 'underscore'

buildExerciseFromState = (state) ->
  {exercise, questions, attachments, tags} = state

  tags = tags.editable.concat(_.map(tags.fixed, (tag) -> tag.value))

  questions = _.map state.questions, (question) ->
    answers = _.map question.answers, (answerId) -> _.findWhere(state.answers,{id: answerId})
    _.extend({}, question, {answers})

  _.extend({}, exercise, {questions, attachments, tags})

module.exports = {buildExerciseFromState}
