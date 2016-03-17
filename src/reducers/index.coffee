
_ = require 'underscore'
{ combineReducers } = require 'redux'

viewState = require './view-state'
exercise = require './exercise'
tags = require './tags'
questions = require './questions'
answers = require './answers'
attachments = require './attachments'

path = window.location.pathname.split("/")

INITIAL_STATE =
  viewState:
    loading: false
    saving: false
    publishing: false
    failed: false
    error: null
    id: if path.length > 2 then path[2] else prompt('Enter exercise id')

  exercise: null
  questions: []
  answers: []
  tags:
    editable: [],
    fixed: []
  attachments: []


reducer = combineReducers({exercise, viewState, tags, attachments, questions, answers})
module.exports = {reducer, INITIAL_STATE}

