window.App = new Backbone.Marionette.Application()

App.Models = {}
App.Views = {}

$ ->
  App.addRegions
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'
    zoomedCardRegion: '.zoomed-card-container'

  card1 = new App.Models.CardModel(cardId: '02009')
  card2 = new App.Models.CardModel(cardId: '03046')
  card3 = new App.Models.CardModel(cardId: '04030')
  card4 = new App.Models.CardModel(cardId: '04031')
  card5 = new App.Models.CardModel(cardId: '04032')
  card6 = new App.Models.CardModel(cardId: '02010')

  noCards = new App.Models.CardCollection()
  noCardsPile1 = new App.Models.PileModel(cards: noCards)
  noCardsPile2 = new App.Models.PileModel(cards: noCards)

  runnerPile1 = new App.Models.PileModel(cards: new App.Models.CardCollection([card1]))
  runnerPile2 = new App.Models.PileModel(cards: new App.Models.CardCollection([card2]))
  corpPile1 = new App.Models.PileModel(cards: new App.Models.CardCollection([card3]))
  corpPile2 = new App.Models.PileModel(cards: new App.Models.CardCollection([card4]))

  runnerPiles = new App.Models.PileCollection([noCardsPile1, runnerPile1, runnerPile2, noCardsPile2])
  corpPiles = new App.Models.PileCollection([noCardsPile1, corpPile1, corpPile2, noCardsPile2])

  runnerHand = new App.Models.CardCollection([card1, card6])
  corpHand = new App.Models.CardCollection([card4, card5])

  runnerModel = new App.Models.PlayerModel(side: 'runner', piles: runnerPiles, hand: runnerHand)
  corpModel = new App.Models.PlayerModel(side: 'corp', piles: corpPiles, hand: corpHand)

  runnerView = new App.Views.PlayerView(model: runnerModel)
  corpView = new App.Views.PlayerView(model: corpModel)

  App.leftPlayRegion.show(runnerView)
  App.rightPlayRegion.show(corpView)
