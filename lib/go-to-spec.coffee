# GoToSpecView = require './go-to-spec-view'
#
# module.exports =
#   goToSpecView: null
#
#   activate: (state) ->
#     @goToSpecView = new GoToSpecView(state.goToSpecViewState)
#
#   deactivate: ->
#     @goToSpecView.destroy()
#
#   serialize: ->
#     goToSpecViewState: @goToSpecView.serialize()

RelatedFileFinder = require './related-file-finder'

module.exports =
  activate: ->
    atom.workspaceView.command 'go-to-spec:toggle', '.editor', ->
      filename = atom.workspaceView.getActivePaneItem().buffer.file.path
      relatedFileHandler(filename)

relatedFileHandler = (filename) ->
  finder = new RelatedFileFinder
  finder.toggle(filename)
