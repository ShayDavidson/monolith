class App.Markdown.Tokenizer
  @parse: (lineText, lineNumber) ->
    new App.Markdown.Tokenizer(lineText, lineNumber).parse()

  constructor: (@lineText, @lineNumber) ->

  parse: ->
    _.find([
      @_parsePlayer(),
      @_parseContext(),
      @_parseCard()
    ])

  _parsePlayer: ->
    playerRegex = /^#\s?(runner|corp)(\s?@\s?(.*))?$/

    result = @lineText.match(playerRegex)
    if (result?)
      type = result[1]
      value = result[3]
      @_makeDescriptor(type, value)
    else
      null

  _parseContext: ->
    regex = /(grip|heap|stack|installed|scored)/

    result = @lineText.match(regex)
    if (result?)
      @_makeDescriptor(result[1], null)
    else
      null

  _parseCard: ->
    card = App.Services.CardFinder.find(@lineText)
    @_makeDescriptor(App.Markdown.ObjectType.Card, card) if (card?)

  _makeDescriptor: (type, value) ->
    new App.Markdown.ObjectDescriptor(@lineText, @lineNumber, type, value)
