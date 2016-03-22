_ = require 'underscore'
{ connect } = require 'react-redux'

mapper = (state, props) ->
  _.findWhere(state.answers, {id: props.id}) or {}

contain = _.partial(connect(mapper))

module.exports = { mapper, contain }
