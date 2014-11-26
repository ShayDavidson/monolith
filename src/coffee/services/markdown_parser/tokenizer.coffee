class Monolith.Markdown.Tokenizer
  @parse: (lineText, lineNumber) ->
    new Monolith.Markdown.Tokenizer(lineText, lineNumber).parse()

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
      identity = Monolith.Services.CardFinder.findIdentity(result[3])
      card = new Monolith.Models.Card(identity)

      @_makeDescriptor(type, card)
    else
      null

  _parseCurrent: ->
    regex = /^#\s?current/

    if (@lineText.match(regex))
      @_makeDescriptor(Monolith.Markdown.ObjectType.Current)
    else
      null

  _parseTokens: ->
    types = Monolith.Markdown.ObjectType
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
    contexts = [
      "grip",
      "heap",
      "stack",
      "installed",
      "scored",
      "rnd",
      "hq",
      "archives",
      "remote",
      "ice"
    ].join("|")
    regex = new RegExp("(#{contexts})(\s?@\s?(.*))?")

    result = @lineText.match(regex)
    if (result?)
      @_makeDescriptor(result[1], result[3])
    else
      null

  _parseCard: ->
    card = Monolith.Services.CardFinder.find(@lineText)
    if (card?)
      card = new Monolith.Models.Card(card)
      @_makeDescriptor(Monolith.Markdown.ObjectType.Card, card)

  _makeDescriptor: (type, value) ->
    new Monolith.Markdown.ObjectDescriptor(@lineText, @lineNumber, type, value)
