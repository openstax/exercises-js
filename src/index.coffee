React = require 'react'
ReactDom = require 'react-dom'

MathJaxHelper =  require 'openstax-react-components/src/helpers/mathjax'

App = require './components/app'

# Just for debugging
window.React = React


loadApp = ->
  MathJaxHelper.startMathJax()
  root = document.getElementById('exercise')

  if not root
    root = document.createElement('div')
    root.setAttribute('id', 'exercise')
    document.body.appendChild(root)

  ReactDom.render(React.createElement(App), root)

document.addEventListener('DOMContentLoaded', loadApp)
