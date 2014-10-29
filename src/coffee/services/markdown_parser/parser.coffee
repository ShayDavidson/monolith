class App.Markdown.MarkdownParser
  TAB_TO_SPACES = '  '

  @parse: (input)->
    new App.Markdown.MarkdownParser().parse(input)

  parse: (@input) ->
    @game = new App.Models.Game(
      parsedAt: Date.now()
    )

    @contextStack = [
      new App.Markdown.GameContext(@game)
    ]

    lines = _.map(@input.split("\n"), (line) => @cleanup(line) )
    @game.set("lines", lines)
    @lastObject = null
    @currentIndent = 0

    _.each(lines, (line, index) =>
      if (line.indent > @currentIndent)
        @contextStack.push(@_currentContext().openContext(@lastObject))
      else if (line.indent < @currentIndent)
        @contextStack.pop()

      @currentIndent = line.indent

      objectDescriptor = @_parseLine(line.line, index)
      if (objectDescriptor?)
        @_currentContext().foundObject(objectDescriptor)
        @lastObject = objectDescriptor
    )

    return @game

  cleanup: (line) ->
    {line: line.trim().toLowerCase(), indent: @countIndent(line)}

  countIndent: (line) ->
    matched = line.replace(/\t/g, TAB_TO_SPACES).match(/^\s+/)
    if matched then matched[0].length else 0

  _currentContext: ->
    @contextStack[@contextStack.length-1]

  _parseLine: (line, index) ->
    @_parsePlayer(line, index) ||
    null

  _parsePlayer: (line, index) ->
    playerRegex = /^#\s?(runner|corp)(\s?@\s?(.*))?$/

    result = line.match(playerRegex)
    if (result?)
      type = result[1]
      value = result[3]
      new App.Markdown.ObjectDescriptor(line, index, type, value)
    else
      null

