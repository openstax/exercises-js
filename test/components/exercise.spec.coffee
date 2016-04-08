{Testing, expect, sinon, _, ReactTestUtils} = require 'openstax-react-components/test/helpers'
{ExercisePreview} = require 'openstax-react-components'

Exercise = require 'components/exercise'
{ExerciseActions} = require 'stores/exercise'
EXERCISE = require 'exercises/1.json'


describe 'Exercises component', ->
  beforeEach ->
    @props =
      exerciseId: '1'
    ExerciseActions.loaded(EXERCISE, @props.exerciseId)

  it 'renders', ->
    Testing.renderComponent( Exercise, props: @props ).then ({dom}) ->
      expect(dom.classList.contains('.exercise-editor')).not.to.true

  it 'renders a preview of the exercise', ->
    Testing.renderComponent( Exercise, props: @props ).then ({element}) ->
      preview = ReactTestUtils.findRenderedComponentWithType(element, ExercisePreview)
      expect(preview.props.exercise).to.deep.equal(
        content: EXERCISE
        tags: _.map EXERCISE.tags, (tag) -> name: tag
      )

  it 'renders with intro and a multiple questions when exercise is MC', ->
    Testing.renderComponent( Exercise, props: @props ).then ({dom}) ->
      tabs = _.pluck dom.querySelectorAll('.nav-tabs li'), 'textContent'
      expect(tabs).to.deep.equal(['Intro', 'Question 1', 'Question 2', 'Tags', 'Assets'])

  it 'renders with out intro and a single question when exercise is MC', ->
    ExerciseActions.toggleMultiPart(@props.exerciseId)
    Testing.renderComponent( Exercise, props: @props ).then ({dom}) ->
      tabs = _.pluck dom.querySelectorAll('.nav-tabs li'), 'textContent'
      expect(tabs).to.deep.equal(['Question', 'Tags', 'Assets'])