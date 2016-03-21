_ = require 'underscore'
{ connect } = require 'react-redux'
mapper = (state, props) -> questions: state.questions

contain = _.partial(connect(mapper))

module.exports = { contain, mapper }
