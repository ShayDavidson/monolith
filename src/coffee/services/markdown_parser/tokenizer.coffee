class App.Markdown.Tokenizer
  @parse: (lineText, lineNumber) ->
    new App.Markdown.Tokenizer(lineText, lineNumber).parse()

  constructor: (@lineText, @lineNumber) ->

  parse: ->
    _.find([
      @_parsePlayer(),
      @_parseCurrent(),
      @_parseTokens(),
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

  _parseCurrent: ->
    regex = /^#\s?current/

    if (@lineText.match(regex))
      @_makeDescriptor(App.Markdown.ObjectType.Current)
    else
      null

  _parseTokens: ->
    types = App.Markdown.ObjectType
    acceptedValues = {
      'credit': types.Credits
      'cred': types.Credits
      'brain damage': types.BrainDamage
      'tag': types.Tags
      'bad publicity': types.BadPublicity
      'bad pub': types.BadPublicity
      'advancement': types.AdvancedmentToken
      'virus': types.VirusToken
      'power': types.GenericToken
      'agenda': types.GenericToken
    }

    regex = new RegExp("^(\\d+)\\s(#{_.keys(acceptedValues).join("|")})(\\s(token|counter))?s?$")
    if (m = @lineText.match(regex))
      @_makeDescriptor(acceptedValues[m[2]], parseInt(m[1]))
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
    if (card?)
      card = new App.Models.Card(card)
      @_makeDescriptor(App.Markdown.ObjectType.Card, card)

  _makeDescriptor: (type, value) ->
    new App.Markdown.ObjectDescriptor(@lineText, @lineNumber, type, value)
