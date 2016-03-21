_ = require 'underscore'
{connect} = require 'react-redux'

mapper = (state) ->
  return _.extend({}, state, {
    id: state.viewState?.id
  })

contain = _.partial(connect(mapper))
module.exports = { mapper, contain }
