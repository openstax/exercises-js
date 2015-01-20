React = require 'react'
{AnswerActions, AnswerStore} = require './flux/answer'
{ExerciseActions, ExerciseStore, EXERCISE_MODES} = require './flux/exercise'
Exercise = require './exercise'
ajax = require './ajax'


# Just for debugging
window.ExerciseActions = ExerciseActions
window.ExerciseStore = ExerciseStore
window.EXERCISE_MODES = EXERCISE_MODES
window.logout = -> ExerciseActions.changeExerciseMode(EXERCISE_MODES.VIEW)

ExerciseActions.changeExerciseMode(EXERCISE_MODES.EDIT)
url = "/test/example.json"

# fetch the exercise JSON
options =
  url: url
  type: 'GET'

ajax options, (err, xhr) ->
  alert('Problem getting exercise') if err

  # Success!
  config = JSON.parse(xhr.responseText)
  # Make sure all questions have ids
  idCounter = 0
  for question in config.questions or []
    question.id = "auto-#{idCounter++}" unless question.id

  root = document.createElement('div')
  root.id = 'exercise'
  document.body.appendChild(root)

  React.renderComponent(Exercise({config}), root)

  # Save on every change
  ExerciseStore.addChangeListener ->

    console.log('Fake Saving')
