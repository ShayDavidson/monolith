class Monolith.Services.MarkdownParser2
  TAB_TO_SPACES = '  '

  @parse: (input)->
    new Monolith.Services.MarkdownParser().parse(input)

  parse: (@input) ->
    @game = new Monolith.Models.Game(
      parsedAt: Date.now()
    )
    @parser = null
    _.each @input.split("\n"), (line) =>
      @parseLine(line)
    @game

  parseLine: (line) ->
    lineDescriptor = @cleanup(line)
    line = lineDescriptor.line
    return if _.isEmpty(line)
    if line == "# runner"
      @parser = new Monolith.Services.RunnerParser(@game.runner())
      return
    if @parser
      @parser.parseLine(lineDescriptor)

  cleanup: (line) ->
    {line: line.trim().toLowerCase(), indent: @countIndent(line)}

  countIndent: (line) ->
    matched = line.replace(/\t/g, TAB_TO_SPACES).match(/^\s+/)
    if matched then matched[0].length else 0

  @parseCounter: (line, acceptedValues) ->
    regex = new RegExp("^(\\d+)\\s(#{acceptedValues.join("|")})$")
    if (m = line.match(regex))
      {type: m[2], amount: parseInt(m[1])}


class Monolith.Services.SectionParser
  constructor: (@object) ->
    @parser = null
    @indent = null

  parseLine: (lineDescriptor)->
    unless @indent?
      @indent = lineDescriptor.indent
    if lineDescriptor.indent == @indent
      console.log(this.constructor.name, "ParseRoot", lineDescriptor)
      @parseRoot(lineDescriptor.line)
    else if @parser
      console.log(this.constructor.name, " >> ", lineDescriptor)
      @parser.parseLine(lineDescriptor)


class Monolith.Services.CardInfoParser extends Monolith.Services.SectionParser
  parseRoot: (line)->
    counter = Monolith.Services.MarkdownParser.parseCounter(line, ['credits', 'virus tokens', 'advancement tokens', 'power tokens'])
    if counter
      @object.set(counter.type, counter.amount)
    card = Monolith.Services.CardFinder.find(line)
    if card
      @card = @object.hostedCards().add(title: card.title, code: card.code)
      @parser = new Monolith.Services.CardInfoParser(@card)


class Monolith.Services.CardParser extends Monolith.Services.SectionParser
  constructor: (@object, options = {}) ->
    super
    @options = _.extend({simple: true}, options)

  parseRoot: (line)->
    card = Monolith.Services.CardFinder.find(line)
    if card
      @card = @object.add(title: card.title, code: card.code)
      if not @options.simple
        @parser = new Monolith.Services.CardInfoParser(@card)

class Monolith.Services.RunnerParser extends Monolith.Services.SectionParser
  parsers:
    'grip': Monolith.Services.GripParser
    'installed': Monolith.Services.RunnerBoardParser
    'heap': Monolith.Services.HeapParser

  parseRoot: (line)->
    counter = Monolith.Services.MarkdownParser.parseCounter(line, ['credits', 'tags', 'brain damage'])
    if counter
      @object.set(counter.type, counter.amount)
    switch line
      when 'grip'
        @parser = new Monolith.Services.CardParser(@object.grip())
        return
      when 'installed'
        @parser = new Monolith.Services.CardParser(@object.installed(), simple: false)
        return
      when 'heap'
        @parser = new Monolith.Services.CardParser(@object.heap())
        return



