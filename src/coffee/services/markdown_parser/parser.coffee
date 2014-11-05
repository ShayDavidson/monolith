class App.Markdown.MarkdownParser
  TAB_TO_SPACES = '  '

  @parse: (input)->
    new App.Markdown.MarkdownParser().parse(input)

  parse: (@input) ->
    @game = new App.Models.Game(
      parsedAt: Date.now()
    )

    @contextStack = []

    @_pushContext(new App.Markdown.GameContext(@game), 0)

    lines = _.map(@input.split("\n"), (line) => @cleanup(line) )
    @lastObject = null
    @currentIndent = 0

    _.each(lines, (line, index) =>
      if (!_.isEmpty(line.line))
        if (line.indent > @currentIndent)
          @_openContext(@lastObject, line.indent)
        else if (line.indent < @currentIndent)
          @_popContext(line.indent)

        @currentIndent = line.indent

        objectDescriptor = App.Markdown.Tokenizer.parse(line.line, index)
        if (objectDescriptor?)
          @_currentContext().foundObject(objectDescriptor)
          console.log(line.line, @_getStackNames())
          if (objectDescriptor.type in [App.Markdown.ObjectType.Runner, App.Markdown.ObjectType.Corp])
            @_openContext(objectDescriptor, line.indent)

          @lastObject = objectDescriptor
    )

    return @game

  cleanup: (line) ->
    {line: line.trim().toLowerCase(), indent: @countIndent(line)}

  countIndent: (line) ->
    matched = line.replace(/\t/g, TAB_TO_SPACES).match(/^\s+/)
    if matched then matched[0].length else 0

  _openContext: (objectDescriptor, indent) ->
    console.log("Opening context", [objectDescriptor.lineText], "under", @_getStackNames())
    @_pushContext(@_currentContext().openContext(objectDescriptor), indent)

  _pushContext: (context, indent) ->
    throw new Error("No context found") unless context?
    @contextStack.push({
      context: context,
      indent: indent
    })

  _popContext: (indent) ->
    @contextStack.pop() # since we allow same-indent contexts, we need to explicitly pop at least once
    while (@contextStack.length > 0 && @_lastContext().indent > indent)
      @contextStack.pop()

    if (!@_lastContext() || @_lastContext().indent < indent)
      throw new Error("Indent mismatch")

  _lastContext: ->
    @contextStack[@contextStack.length-1]

  _currentContext: ->
    @_lastContext()?.context

  _getStackNames: ->
    _.map(@contextStack, (ctx) ->
      ctx.context.constructor.name
    )