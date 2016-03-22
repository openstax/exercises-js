React = require 'react'
BS = require 'react-bootstrap'
_ = require 'underscore'
{updateEditable, updateFixed} = require '../../actions/tags'
{ connect } = require 'react-redux'

FixedTag = React.createClass
  updateTag: (event) ->
    newValue = event.target?.value
    @props.dispatch(updateFixed(@props.base, @props.value, newValue))

  renderRangeValue: (value) ->
    optionValue = "#{@props.base}#{@props.separator}#{value}"
    <option key={value} value={optionValue}>{optionValue}</option>

  render: ->
    <select onChange={@updateTag} defaultValue={@props.value}>
      <option value=''>No {@props.base} tag</option>
      {_.map(@props.range, @renderRangeValue)}
    </select>

FixedTag = connect()(FixedTag)

ExerciseTags = React.createClass
  displayName: 'ExerciseTags'

  updateTags: (event) ->
    tagsArray = event.target?.value.split("\n")
    @props.dispatch(updateEditable(tagsArray))

  renderFixedTag: (fixedTag) ->
    <FixedTag key={fixedTag.base} id={@props.id} {...fixedTag} />

  render: ->
    {fixed, editable} = @props

    fixed = _.map(_.sortBy(fixed, "base"), @renderFixedTag)

    <BS.Row className="tags">
      <p><label>Tags</label></p>
      <BS.Col xs={6}>
        <textarea onChange={@updateTags} defaultValue={editable.join('\n')}>
        </textarea>
      </BS.Col>
      <BS.Col xs={6}>
        {fixed}
      </BS.Col>
    </BS.Row>

module.exports = connect((props) -> props.tags)(ExerciseTags)
