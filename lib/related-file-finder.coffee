fs = require 'fs'

module.exports =
class RelatedFileFinder

  relatedFilenamePath: (filenamePath) ->
    if filenamePath.match /_(spec|text)\.rb$/
      filenamePath.replace /(.*)\/(spec|test)(\/lib)?\/(.*)_(spec|test)\.rb$/, (a,prefix, b,lib,path,d) ->
        if lib
          prefix + '/lib/' + path + '.rb'
        else
          prefix + '/app/' + path + '.rb'
    else if filenamePath.match /\.rb$/
      filenamePath.replace /(.*)\/(app|lib)\/(.*)\.rb$/, (a,prefix, app_or_lib,suffix) ->
        if app_or_lib is 'lib'
          prefix + '/spec/lib/' + suffix + '_spec.rb'
        else
          prefix + '/spec/' + suffix + '_spec.rb'

  toggle: (filenamePath) ->
    related_filename = @relatedFilenamePath(filenamePath)
    fs.open related_filename, 'wx', (err, fd) ->
      if ! err
        fs.writeFile(related_filename, "")
    atom.workspaceView.open(related_filename)
