
React = require 'react'

PublishedLabel = React.createClass
  render: ->
    if @props.published_at
      published = <div className="published-label">
        <div>
          <label>Published: {@props.published_at}</label>
        </div>
        <div>
          <a href="/exercise/#{@props.id}">Edit Exercise</a>
        </div>
      </div>

    <div>
      <div><label>Exercise ID:</label> {@props.uid}</div>
      {published}
    </div>

module.exports = PublishedLabel
