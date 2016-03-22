_ = require 'underscore'
Constants = require '../actions/constants'

INITIAL_STATE =
  stem_html:"",
  stimulus_html:"",
  formats:[],
  collaborator_solutions: [
    content_html: "",
    solution_type: "detailed"
  ],
  answers:[],
  is_answer_order_important: false

__FORMATS =
  freeResponse: 'free-response'
  multipleChoice: 'multiple-choice'

hasFormat = (formats, form) ->
  _.find formats, (format) -> format is form

toggleFormat = (formats, form) ->
  if hasFormat(formats, form)
    _.reject formats, (format) -> format is form
  else
    formats.concat([form])

reducer = (state = INITIAL_STATE, {type: action, payload}) ->
  if state.id isnt payload?.id then return state

  if action is Constants.UPDATE_QUESTION_STEM

    return _.extend({}, state, {stem_html: payload.stem_html})

  else if action is Constants.UPDATE_QUESTION_STIMULUS

    return _.extend({}, state, {stimulus_html: payload.stimulus_html})

  else if action is Constants.UPDATE_SOLUTION

    solution = _.extend({}, _.first(state.collaborator_solutions), {content_html: payload.content_html})
    return _.extend({}, state, {collaborator_solutions: [solution]})

  else if action is Constants.ADD_ANSWER

    answers = state.answers.concat([payload.newAnswerId])
    return _.extend({}, state, {answers})

  else if action is Constants.REMOVE_ANSWER

    answers = _.filter(state.answers, (answer) -> answer isnt payload.answerId)
    return _.extend({}, state, {answers})

  else if action is Constants.MOVE_ANSWER
    answers = state.answers.slice()
    index = _.findIndex answers, (answer) -> answer is payload.answerId

    if (index isnt -1)
      temp = answers[index]
      answers[index] = answers[index + payload.direction]
      answers[index + payload.direction] = temp

    return _.extend({}, state, {answers})

  else if action is Constants.TOGGLE_MULTIPLE_CHOICE

    formats = toggleFormat(state.formats, __FORMATS.multipleChoice)
    return _.extend({}, state, {formats})

  else if action is Constants.TOGGLE_FREE_RESPONSE

    formats = toggleFormat(state.formats, __FORMATS.freeResponse)
    return _.extend({}, state, {formats})

  else if action is Constants.TOGGLE_PRESERVE_ORDER

    return _.extend({}, state, {is_answer_order_important: not state.is_answer_order_important})

  else

    return state

module.exports = {reducer, INITIAL_STATE}
