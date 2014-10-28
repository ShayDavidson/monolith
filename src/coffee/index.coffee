window.Monolith = new Backbone.Marionette.Application()

Monolith.Models = {}
Monolith.Views = {}

$ ->
  Monolith.addRegions
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'
    zoomedCardRegion: '.zoomed-card-container'

  card1 = new Monolith.Models.CardModel(cardId: '02009')
  card2 = new Monolith.Models.CardModel(cardId: '03046')
  card3 = new Monolith.Models.CardModel(cardId: '04030')
  card4 = new Monolith.Models.CardModel(cardId: '04031')
  card5 = new Monolith.Models.CardModel(cardId: '04032', faceUp: true)
  card6 = new Monolith.Models.CardModel(cardId: '03047', faceUp: true)
  card7 = new Monolith.Models.CardModel(cardId: '03048', faceUp: true)
  card8 = new Monolith.Models.CardModel(cardId: '03049', faceUp: true)
  card9 = new Monolith.Models.CardModel(cardId: '03049', faceUp: true)
  card10 = new Monolith.Models.CardModel(cardId: '04033', faceUp: true)

  array = []
  _.times(50, -> array.push(new Monolith.Models.CardModel(cardId: '02009', faceUp: false)))

  noCards = new Monolith.Models.CardCollection()
  noCardsPile1 = new Monolith.Models.PileModel(cards: noCards)
  noCardsPile2 = new Monolith.Models.PileModel(cards: noCards)

  runnerPile1 = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection(array))
  runnerPile2 = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection([card2]))
  corpPile1 = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection([card1, card2, card3, card4, card5, card6, card7, card8, card9, card10]))
  corpPile2 = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection([card4]))

  runnerPiles = new Monolith.Models.PileCollection([noCardsPile1, runnerPile1, runnerPile2, noCardsPile2])
  corpPiles = new Monolith.Models.PileCollection([noCardsPile1, corpPile1, corpPile2, noCardsPile2])

  runnerHand = new Monolith.Models.CardCollection([card9, card6, card7, card8])
  corpHand = new Monolith.Models.CardCollection([card10, card5])

  runnerModel = new Monolith.Models.PlayerModel(type: 'runner', side: 'left', piles: runnerPiles, hand: runnerHand, credits: 2)
  corpModel = new Monolith.Models.PlayerModel(type: 'corp', side: 'right', piles: corpPiles, hand: corpHand, credits: 5)

  runnerView = new Monolith.Views.PlayerView(model: runnerModel)
  corpView = new Monolith.Views.PlayerView(model: corpModel)

  if runnerModel.get('side') == 'left'
    Monolith.leftPlayRegion.show(runnerView)
    Monolith.rightPlayRegion.show(corpView)
  else
    Monolith.rightPlayRegion.show(runnerView)
    Monolith.leftPlayRegion.show(corpView)

  $(window).trigger('resize') # fixes some issues with card sizes.
