class Monolith.Models.Markdown extends Backbone.Model
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

  cardToPile: (card) ->
    cardsCollection = new Monolith.ViewModels.CardViewCollection([@cardToViewModel(card)])
#    TODO: Return when hosting is working again
#    if card.hostedCards().length > 0
#      pile = @cardToPile(card.hostedCards().first())
#      cardsCollection.add(pile.get('cards').models)
    new Monolith.ViewModels.PileViewModel(cards: cardsCollection)

  translate: ->
    game = Monolith.Markdown.MarkdownParser.parse(@get('text'))
    @set('game', game)

    emptyPile = -> new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection())
    deckPile = ->
      decksArray = []
      _.times(30, -> decksArray.push(new Monolith.ViewModels.CardViewModel()))
      new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection(decksArray))

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
    runnerHand = new Monolith.ViewModels.CardViewCollection(handCards)

    heapCards = []
    runnerPlayer.heap().forEach (card) =>
      heapCards.push(@cardToViewModel(card))
    runnerHeap = new Monolith.ViewModels.CardViewCollection(heapCards)
    runnerHeapPile = new Monolith.ViewModels.PileViewModel(cards: runnerHeap)

    runnerCredits = new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: runnerPlayer.get('credits'))
    runnerTags = new Monolith.ViewModels.TokensViewModel(type: 'tag', amount: runnerPlayer.get('tags'))
    runnerTokens = new Monolith.ViewModels.TokensViewCollection([runnerCredits, runnerTags])

    runnerIdentity = runnerPlayer.get('identity')
    if runnerIdentity
      runnerIDPile = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection([@cardToViewModel(runnerIdentity)]))
    else
      runnerIDPile = emptyPile()

    installedPiles = []
    runnerPlayer.installed().forEach (card) =>
      installedPiles.push(@cardToPile(card))

    runnerPiles = new Monolith.ViewModels.PileViewCollection(installedPiles.concat([
      runnerIDPile,
      deckPile(),
      runnerHeapPile,
    ]))

    @get('viewModel').get('runner').set(
      hand: runnerHand
      tokens: runnerTokens
      piles: runnerPiles
    )