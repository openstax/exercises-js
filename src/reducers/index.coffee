
_ = require 'underscore'
{ combineReducers } = require 'redux'

viewState = require './view-state'
exercise = require './exercise'
tags = require './tags'
questions = require './questions'
answers = require './answers'
attachments = require './attachments'


INITIAL_STATE =
  viewState: viewState.INITIAL_STATE
  exercise: exercise.INITIAL_STATE
  questions: questions.INITIAL_STATE
  answers: answers.INITIAL_STATE
  tags: tags.INITIAL_STATE
  attachments: attachments.INITIAL_STATE


reducer = combineReducers(
  exercise: exercise.reducer,
  viewState: viewState.reducer,
  tags: tags.reducer,
  attachments: attachments.reducer,
  questions: questions.reducer,
  answers: answers.reducer
)
module.exports = {reducer, INITIAL_STATE}

