React = require 'react'

{AnswerActions, AnswerStore} = require './stores/answer'
{QuestionActions, QuestionStore} = require './stores/answer'
{ExerciseActions, ExerciseStore} = require './stores/exercise'

MathJaxHelper =  require 'openstax-react-components/src/helpers/mathjax'
Exercise = require './components/exercise'
ExerciseWrapper = require './components/exercise-wrapper'
api = require './api'


# Just for debugging
window.React = React
window.ExerciseComponent = React.createFactory(ExerciseWrapper)
window.ExerciseActions = ExerciseActions
window.ExerciseStore = ExerciseStore
window.AnswerStore = AnswerStore
window.QuestionStore = QuestionStore
window.logout = -> ExerciseActions.changeExerciseMode(EXERCISE_MODES.VIEW)


loadApp = ->
  api.start()

  MathJaxHelper.startMathJax()
  root = document.getElementById('exercise')

  if not root
    root = document.createElement('div')
    root.setAttribute('id', 'exercise')
    document.body.appendChild(root)

  pathArr = window.location.pathname.split("/")
  if (pathArr.length > 2)
    config = {
      exerciseId: pathArr[2]
    }

  exercise = window.ExerciseComponent(config)
  window.React.render(exercise, root)

document.addEventListener('DOMContentLoaded', loadApp)
