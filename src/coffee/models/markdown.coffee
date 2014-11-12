class Monolith.Models.Markdown extends Backbone.Model
  defaults:
    text: '#runner @ kit\n3 credits\ninstalled\n\tdatasucker\ngrip\n\tsure gamble\n\tparasite'
    game: null
    viewModel: null

  cardToViewModel: (card, options = {}) ->
    console.log(card)
    opts = _.extend({cardId: card.get('code'), faceUp: true}, options)
    new Monolith.ViewModels.CardViewModel(opts)

  translate: ->
    game = Monolith.Markdown.MarkdownParser.parse(@get('text'))
    @set('game', game)

    emptyPile = -> new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection())
    deckPile = ->
      decksArray = []
      _.times(30, -> decksArray.push(new Monolith.ViewModels.CardViewModel()))
      new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection(decksArray))


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

    runnerPiles = new Monolith.ViewModels.PileViewCollection([
        emptyPile(),
        runnerIDPile,
        deckPile(),
        runnerHeapPile,
      ]
    )

    @get('viewModel').get('runner').set(
      hand: runnerHand
      tokens: runnerTokens
      piles: runnerPiles
    )