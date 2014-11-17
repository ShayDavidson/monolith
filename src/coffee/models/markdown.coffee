class Monolith.Models.Markdown extends Backbone.Model
  _.extend this::, Monolith.Mixins.Sugar::

  defaults:
    text: """
       #runner @ kit
       3 credits
       installed
         cache
           7 virus counters
         datasucker
           2 virus
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
    opts = _.extend({cardId: card.get('code'), faceUp: true}, options)
    cardTokens = new Monolith.ViewModels.TokensViewCollection()
    if (amount = card.get('credits'))
      cardTokens.push(new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: amount ))
    if (amount = card.get('virusTokens'))
      cardTokens.push(new Monolith.ViewModels.TokensViewModel(type: 'virus', amount: amount ))
    if (amount = card.get('advancementTokens'))
      cardTokens.push(new Monolith.ViewModels.TokensViewModel(type: 'advancement', amount: amount ))
    if (amount = card.get('genericTokens'))
      cardTokens.push(new Monolith.ViewModels.TokensViewModel(type: 'generic', amount: amount ))
    opts.tokens = cardTokens unless cardTokens.length == 0
    new Monolith.ViewModels.CardViewModel(opts)

  cardToRow: (card) ->
    cardPiles = [@cardToViewModel(card)]
#    TODO: Return when hosting is working again
#    if card.hostedCards().length > 0
#      row = @cardToRow(card.hostedCards().first())
#      cardsCollection.add(row.get('cards').models)
    new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection(cardPiles))

  translate: ->
    game = Monolith.Markdown.MarkdownParser.parse(@get('text'))
    @set('game', game)

    emptyRow = -> new Backbone.Collection([])
    deckRow = =>
      decksArray = []
      _.times(30, => decksArray.push(@faceDownCard()))
      new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection(decksArray))

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
    runnerHeapRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection(runnerHeap))

    runnerCredits = @tokens('credit', runnerPlayer.get('credits'))
    runnerTags = @tokens('tag', runnerPlayer.get('tags'))
    runnerTokens = @tokensCollection([runnerCredits, runnerTags])

    runnerIdentity = runnerPlayer.get('identity')
    if runnerIdentity
      runnerIDRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([@cardToViewModel(runnerIdentity)]))
    else
      runnerIDRow = emptyRow()

    installedRows = []
    runnerPlayer.installed().forEach (card) =>
      installedRows.push(@cardToRow(card))

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