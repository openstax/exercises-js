_ = require 'underscore'
Constants = require '../actions/constants'

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

QuestionReducer = (state = [], {type: action, payload}) ->
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

    return _.extend({}, state, {is_answer_order_important: !state.is_answer_order_important})

  else

    return state

module.exports = (state = [], {type: action, payload}) ->
  if action is Constants.EXERCISE_LOAD

    return []

  else if action is Constants.EXERCISE_LOADED
    return _.map payload.questions, (question) ->
      answers = _.map(question.answers, (answer) -> answer.id)
      _.extend({}, question, {answers})


  else if (action is Constants.UPDATE_QUESTION_STIMULUS or
  action is Constants.UPDATE_QUESTION_STEM or
  action is Constants.UPDATE_SOLUTION or
  action is Constants.ADD_ANSWER or
  action is Constants.REMOVE_ANSWER or
  action is Constants.MOVE_ANSWER or
  action is Constants.TOGGLE_MULTIPLE_CHOICE or
  action is Constants.TOGGLE_FREE_RESPONSE or
  action is Constants.TOGGLE_PRESERVE_ORDER)

    return _.map state, (question) ->
      QuestionReducer(question, {payload, type: action})

  return state
