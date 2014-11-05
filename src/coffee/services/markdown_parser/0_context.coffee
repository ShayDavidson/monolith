class Monolith.Markdown.Context
  foundObject: (objectDescriptor) ->
    throw new Error("##{objectDescriptor.lineNumber}: #{objectDescriptor.lineText} doesn't belong inside #{@constructor.name}")
