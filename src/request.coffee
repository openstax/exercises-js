$ = require 'jquery'
_ = require 'underscore'

# Do some special things when running without a tutor-server backend.
#
# - suffix calls with `.json` so we can have `/plans` and `/plans/1`
#   - otherwise there would be a file named `plans` and a directory named `plans`
# - do not error when a PUT occurs
IS_LOCAL = window.location.port is '8001' or window.__karma__
CSRF_Token = document.head.querySelector('meta[name=csrf-token]')?.getAttribute("content")

delay = (ms, fn) -> setTimeout(fn, ms)


module.exports = (args) ->
  # Make sure API calls occur **after** all local Action listeners complete
  delay 20, ->
    {url, payload, method, success, fail} = args

    opts =
      method: method
      dataType: 'json'
      headers:
        'X-CSRF-Token': CSRF_Token,

    if payload?
      opts.data = JSON.stringify(payload)
      opts.processData = false
      # For now, the backend is expecting JSON and cannot accept url-encoded forms
      opts.contentType = 'application/json'

    if IS_LOCAL
      [uri, params] = url.split("?")
      if opts.method is 'GET'
        url = "#{uri}.json?#{params}"
      else
        url = "#{uri}/#{opts.method}.json?#{params}"
        opts.method = 'GET'

    resolved = (results, statusStr, jqXhr) ->
      success(results, args...) # Include listenAction for faking
    rejected = (jqXhr, statusMessage, err) ->
      statusCode = jqXhr.status
      if statusMessage is 'parsererror' and statusCode is 200 and IS_LOCAL
        if httpMethod is 'PUT' or httpMethod is 'PATCH'
          # HACK for PUT
          success(null, args...)
        else
          # Hack for local testing. Webserver returns 200 + HTML for 404's
          fail(404, 'Error Parsing the JSON or a 404', args...)
      else if statusCode is 404
        fail(statusCode, 'ERROR_NOTFOUND', args...)
      else
        # Parse the error message and fail
        try
          msg = JSON.parse(jqXhr.responseText)
        catch e
          msg = jqXhr.responseText
        fail(statusCode, msg, args...)

    $.ajax(url, opts)
    .then(resolved, rejected)


