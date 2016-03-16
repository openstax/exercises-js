{createAction} = require 'redux-actions'
Constants = require './constants'

updateEditable = createAction(Constants.UPDATE_EDITABLE_TAGS, (tags) -> { tags })
updateFixed = createAction(Constants.UPDATE_FIXED_TAGS, (base, old, value) -> {base, old, value})

module.exports = {updateEditable, updateFixed}
