class App.Markdown.Context
  foundObject: (objectDescriptor) ->
    throw new Error("#{objectDescriptor.lineText}##{objectDescriptor.lineNumber} doesn't belong inside")
