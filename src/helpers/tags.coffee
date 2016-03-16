_ = require 'underscore'

FixedTags = [{
  base: 'blooms'
  range: [1...8]
  separator: '-'
}, {
  base: 'dok'
  range: [1...4]
  separator: ''
}, {
  base: 'time'
  range: ['short', 'medium', 'long']
  separator: '-'
}]

isFixedTagType = (tag, fixedTag) -> tag.indexOf("#{fixedTag.base}#{fixedTag.separator}") isnt -1

getTagTypes = (tags) ->
  #filter out all editable tags
  editable = _.filter tags, (tag) ->
    _.reduce(FixedTags, (memo, fixedTag) ->
      memo and not isFixedTagType(tag, fixedTag)
    , true)

  fixedArray = _.filter tags, (tag) -> editable.indexOf(tag) is -1

  #get all fixed tags with value attribute
  fixed = _.map(FixedTags, (fixedTag) ->
    value = _.reduce(fixedArray, (memo, tag) ->
      if isFixedTagType(tag, fixedTag)
        tag
      else
        memo
    , '')

    _.extend({}, fixedTag, {value})
  )

  #return both types of tags
  return {fixed, editable}

createFixed = (base, value) ->
  _.extend({}, _.findWhere(FixedTags, {base}), {value})

module.exports = {FixedTags, isFixedTagType, getTagTypes, createFixed}
