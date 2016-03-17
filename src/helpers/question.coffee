
idCounter = 0
CREATE_KEY = -> "_CREATING_#{idCounter++}"

_ = require 'underscore'
AnswerHelper = require './answer'

getCorrectAnswer = (question) ->
  _.find question.answers, (answer) -> AnswerHelper.isCorrect(answer)

getSolution = (question) ->
  _.first(question.collaborator_solutions)?.content_html

isMultipleChoice = (question) ->
  question.formats?.indexOf('multiple-choice') isnt -1

isFreeResponse = (question) ->
  question.formats?.indexOf('free-response') isnt -1

newAnswerId = -> CREATE_KEY()

module.exports = { getSolution, isMultipleChoice, isFreeResponse, getCorrectAnswer, newAnswerId}
