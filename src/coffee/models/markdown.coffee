class Monolith.Models.Markdown extends Backbone.Model
  _.extend this::, Monolith.Mixins.Sugar::

  defaults:
    text: """
       #runner @ kit
       3 credits
       installed
         cache
           7 virus counters
         dinosaurus
           yog.0
       grip
         sure gamble
         parasite

       #current
       net celebrity
     """
    game: null
    viewModel: null

  cardToViewModel: (card, options = {}) ->
    opts = _.extend({faceUp: true}, options)
    cardTokens = new Monolith.ViewModels.TokensViewCollection()
    if (amount = card.get('credits'))
      cardTokens.push(@tokens('credit', amount))
    if (amount = card.get('virusTokens'))
      cardTokens.push(@tokens('virus', amount))
    if (amount = card.get('advancementTokens'))
      cardTokens.push(@tokens('advancement', amount))
    if (amount = card.get('genericTokens'))
      cardTokens.push(@tokens('generic', amount))
    opts.tokens = cardTokens unless cardTokens.length == 0
    @faceUpCard(card.get('code'), opts)

  translate: ->
    game = Monolith.Markdown.MarkdownParser.parse(@get('text'))
    @set('game', game)

    deckRow = =>
      decksArray = []
      _.times(30, => decksArray.push(@faceDownCard()))
      @row([decksArray])

    # CURRENT
    currentCardModel = game.get('current')
    if currentCardModel?
      @get('viewModel').set('current', @cardToViewModel(currentCardModel))
    else
      @get('viewModel').unset('current')

    # RUNNER
    runnerPlayer = game.get('runner')

    handCards = []
    runnerPlayer.grip().forEach (card) =>
      handCards.push(@cardToViewModel(card))
    runnerHand = handCards

    heapCards = []
    runnerPlayer.heap().forEach (card) =>
      heapCards.push(@cardToViewModel(card))
    runnerHeap = heapCards
    runnerHeapRow = @row([runnerHeap])

    runnerCredits = @tokens('credit', runnerPlayer.get('credits'))
    runnerTags = @tokens('tag', runnerPlayer.get('tags'))
    runnerTokens = @tokensCollection([runnerCredits, runnerTags])

    runnerIdentity = runnerPlayer.get('identity')
    if runnerIdentity
      runnerIDRow = @row([@cardToViewModel(runnerIdentity)])
    else
      runnerIDRow = @row()

    installedRows = []
    runnerPlayer.installed().forEach (card) =>
      installedRows.push(@row([@cardToViewModel(card)]))

    runnerRows = installedRows.concat([
      runnerIDRow,
      deckRow(),
      runnerHeapRow,
    ])

    @get('viewModel').get('runner').set(
      hand: @cards(runnerHand)
      rows: @rows(runnerRows)
      tokens: runnerTokens
    )