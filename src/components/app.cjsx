React = require 'react'
{ Provider } = require 'react-redux'
{ createDevTools } = require 'redux-devtools'
LogMonitor = require 'redux-devtools-log-monitor'
DockMonitor = require 'redux-devtools-dock-monitor'
Inspector = require 'redux-devtools-inspector'

DockMonitor = DockMonitor.default
LogMonitor = LogMonitor.default
Inspector = Inspector.default

{configureDevStore, configureProdStore} = require '../store'
Exercise = require './Exercise'

IS_LOCAL = (window.location.port is '8001' or window.__karma__ or window.location.href.indexOf('localhost') isnt -1)

if IS_LOCAL
  DevTools = createDevTools(<DockMonitor
    toggleVisibilityKey="ctrl-h"
    changePositionKey="ctrl-q"
    changeMonitorKey="ctrl-m"
    defaultPosition="bottom"
    defaultIsVisible={false} >
    <LogMonitor theme="tomorrow"/>
    <Inspector />
  </DockMonitor>)
  store = configureDevStore(DevTools?.instrument)
else
  DevTools = <div></div>
  store = configureProdStore()



App = React.createClass
  render: ->
    devTools = @renderDevTools()
    <Provider store={store}>
      <div>
        <Exercise />
        { devTools }
      </div>
    </Provider>

  renderDevTools: ->
    if IS_LOCAL
      <DevTools />
    else
      <div />


module.exports = App
