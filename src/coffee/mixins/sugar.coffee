class Monolith.Mixins.Sugar

  game: (options) ->
    new Monolith.ViewModels.GameViewModel(options)

  row: (piles = []) ->
    piles = _.map(piles, (cards) ->
      cards = [cards] unless _.isArray(cards)
      new Monolith.ViewModels.PileViewModel(cards: new Backbone.Collection(cards))
    )
    new Monolith.ViewModels.RowViewModel(piles: new Backbone.Collection(piles))

  rows: (rows) ->
    new Backbone.Collection(rows)

  cards: (cards) ->
    new Backbone.Collection(cards)

  faceUpCard: (id, options = {}) ->
    options.cardId = id
    options.faceUp = true
    new Monolith.ViewModels.CardViewModel(options)

  faceDownCard: (options = {}) ->
    new Monolith.ViewModels.CardViewModel(options)

  player: (type, side, rows, hand, tokens) ->
    new Monolith.ViewModels.PlayerViewModel(type: type, side: side, rows: rows, hand: hand, tokens: tokens)

  tokens: (type, amount) ->
    new Monolith.ViewModels.TokensViewModel(type: type, amount: amount)

  tokensCollection: (tokens) ->
    new Monolith.ViewModels.TokensViewCollection(tokens)