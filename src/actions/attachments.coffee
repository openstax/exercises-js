{createAction} = require 'redux-actions'
Constants = require './constants'
request = require '../request'

CSRF_Token = document.head.querySelector('meta[name=csrf-token]')?.getAttribute("content")

uploadExerciseImage = (exerciseUid, image, cb) ->
  url = "/api/exercises/#{exerciseUid}/attachments"
  xhr = new XMLHttpRequest()
  xhr.addEventListener 'load', (req) ->
    cb(if req.currentTarget.status is 201
      attachment = JSON.parse(req.target.response)
      {response: attachment, progress: 100}
    else
      {error: req.currentTarget.statusText})
  xhr.addEventListener 'progress', (ev) ->
    cb({progress: (ev.total / (ev.total or image.size) * 100) })
  xhr.open('POST', url, true)
  xhr.setRequestHeader('X-CSRF-Token', CSRF_Token)
  form = new FormData()
  form.append("image", image, image.name)
  xhr.send(form)

attachmentUploaded = createAction(Constants.UPLOADED_ATTACHMENT, (attachment) -> {attachment})

deleteAttachment = createAction(Constants.DELETE_ATTACHMENT, (id) -> {id})
deletedAttachment = createAction(Constants.DELETED_ATTACHMENT, (id) -> {id})
errorDeleteAttachment = createAction(Constants.ERROR_DELETED_ATTACHMENT, (id) -> {id})

remove = (exerciseUid, attachmentId) ->
  (dispatch) ->
    dispatch(deleteAttachment())
    request
      url: "/api/exercises/#{exerciseUid}/attachments/#{attachmentId}"
      method: 'DELETE'
      success: => dispatch(deletedAttachment(attachmentId))
      fail: => dispatch(errorDeleteAttachment(attachmentId))

module.exports = {uploadExerciseImage, attachmentUploaded, remove}
