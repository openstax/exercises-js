{ createStore, applyMiddleware, compose } = require 'redux'
thunkMiddleware = require 'redux-thunk'
diffMiddleware = require 'redux-diff-logger'
{ reducer, INITIAL_STATE } = require './reducers'

configureDevStore = (instrument) ->
  createStore(
    reducer,
    INITIAL_STATE,
    compose(
      applyMiddleware(thunkMiddleware.default, diffMiddleware)
      instrument()
    )
  )

configureProdStore = ->
  createStore(
    reducer,
    INITIAL_STATE,
    compose(applyMiddleware(thunkMiddleware.default))
  )

module.exports = {configureDevStore, configureProdStore}
