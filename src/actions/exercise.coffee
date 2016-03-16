_ = require 'underscore'
request = require '../request'
{ createAction } = require 'redux-actions'
Constants = require './constants'
{ buildExerciseFromState } = require '../helpers/exercise'

loadExercise = createAction(Constants.EXERCISE_LOAD)
loadedExercise = createAction(Constants.EXERCISE_LOADED)
errorLoadExercise = createAction(Constants.ERROR_LOAD_EXERCISE)

saveExercise = createAction(Constants.EXERCISE_SAVE)
savedExercise = createAction(Constants.EXERCISE_SAVED)
errorSaveExercise = createAction(Constants.ERROR_SAVE_EXERCISE)

publishExercise = createAction(Constants.EXERCISE_PUBLISH)
publishedExercise = createAction(Constants.EXERCISE_PUBLISHED)
errorPublishExercise = createAction(Constants.ERROR_PUBLISH_EXERCISE)

Actions =
  updateStimulus: createAction(Constants.UPDATE_EXERCISE_STIMULUS)
  load: (id) ->
    (dispatch, state) ->
      dispatch(loadExercise())
      request
        url: "/api/exercises/#{id}@draft"
        method: 'GET'
        success: (data) => dispatch(loadedExercise(data))
        fail: (data) => dispatch(errorLoadExercise(data))

  save: (id) ->
    (dispatch, getState) ->
      exercise = buildExerciseFromState(getState())
      data = _.extend({}, exercise, {exercise})

      dispatch(saveExercise())
      request
        url:"/api/exercises/#{id}@draft"
        method: 'PUT'
        payload: data
        success: (data) => dispatch(loadedExercise(data))
        fail: (data) => dispatch(errorSavedExercise(data))

  publish: (id) ->
    (dispatch, getState) ->
      exercise = buildExerciseFromState(getState())
      uid = exercise.uid

      dispatch(publishExercise())
      request
        url: "/api/exercises/#{uid}/publish"
        method: 'PUT'
        payload: exercise
        success: (data) => dispatch(loadedExercise(data))
        fail: (data) => dispatch(errorPublishExercise(data))

module.exports = {Actions}
