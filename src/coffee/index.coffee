window.App = new Backbone.Marionette.Application()

App.Models = {}
App.Views = {}

$ ->
  App.addRegions
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'

  card = new App.Models.CardModel()
  cards = new App.Models.CardCollection([card])
  noCards = new App.Models.CardCollection()
  pile1 = new App.Models.PileModel(cards: noCards)
  pile2 = new App.Models.PileModel(cards: cards)
  pile3 = new App.Models.PileModel(cards: cards)
  pile4 = new App.Models.PileModel(cards: noCards)
  piles = new App.Models.PileCollection([pile1, pile2, pile3, pile4])

  runnerModel = new App.Models.PlayerModel(side: 'runner', piles: piles)
  corpModel = new App.Models.PlayerModel(side: 'corp', piles: piles)

  runnerView = new App.Views.PlayerView(model: runnerModel)
  corpView = new App.Views.PlayerView(model: corpModel)

  App.leftPlayRegion.show(runnerView)
  App.rightPlayRegion.show(corpView)
