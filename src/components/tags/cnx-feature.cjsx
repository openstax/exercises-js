React = require 'react'

MultiInput = require './multi-input'

CnxModTag = React.createClass

  propTypes:
    exerciseId: React.PropTypes.string.isRequired

  validateInput: (value) ->
    'Must match CNX feature' unless value.match(
      /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}#[\w-]+$/i
    )

  cleanInput: (val) ->
    val.replace(/[^0-9a-z-#]/g, '')

  render: ->
    <MultiInput
      {...@props}
      label='CNX Feature'
      prefix='cnx-feature'
      cleanInput={@cleanInput}
      validateInput={@validateInput}
    />

module.exports = CnxModTag