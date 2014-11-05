window.Monolith = new Backbone.Marionette.Application()

Monolith.Models = {}
Monolith.Views = {}

$ ->

  # Regions

  Monolith.addRegions
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'
    zoomedCardRegion: '.zoomed-card-container'

  # Cards

  ## Corp

  corpId    = new Monolith.Models.CardModel(cardId: '04097', faceUp: true) # GRNDL
  corpHand1 = new Monolith.Models.CardModel(cardId: '01086', faceUp: true) # SEA Source
  corpHand2 = new Monolith.Models.CardModel(cardId: '01110', faceUp: true) # Hedge Fund
  corpHand3 = new Monolith.Models.CardModel(cardId: '01099', faceUp: true) # Scorched Earth
  corpHand4 = new Monolith.Models.CardModel(cardId: '01099', faceUp: true) # Scorched Earth
  corpHand5 = new Monolith.Models.CardModel(cardId: '01090', faceUp: true) # Tollbooth

  corpTrash1 = new Monolith.Models.CardModel(cardId: '04040', faceUp: true) # Restructure

  ## Runner

  runnerId    = new Monolith.Models.CardModel(cardId: '03028', faceUp: true) # Kit
  runnerHand1 = new Monolith.Models.CardModel(cardId: '04109', faceUp: true) # Lucky Find
  runnerHand2 = new Monolith.Models.CardModel(cardId: '02047', faceUp: true) # Test Run
  runnerHand3 = new Monolith.Models.CardModel(cardId: '04047', faceUp: true) # Torch
  runnerHand4 = new Monolith.Models.CardModel(cardId: '01034') # Diesel
  runnerHand5 = new Monolith.Models.CardModel() # Diesel

  # Piles

  decksArray = []
  _.times(30, -> decksArray.push(new Monolith.Models.CardModel()))

  noCards = new Monolith.Models.CardCollection()
  firstNoCardsPile = new Monolith.Models.PileModel(cards: noCards)
  lastNoCardsPile = new Monolith.Models.PileModel(cards: noCards)

  runnerDeck = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection(decksArray))
  corpDeck = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection(decksArray))

  runnerIdPile = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection([runnerId]))
  corpIdPile = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection([corpId]))

  corpTrash = new Monolith.Models.PileModel(cards: new Monolith.Models.CardCollection([corpTrash1]))

  runnerPiles = new Monolith.Models.PileCollection([firstNoCardsPile, runnerIdPile, runnerDeck, lastNoCardsPile])
  corpPiles = new Monolith.Models.PileCollection([firstNoCardsPile, corpIdPile, corpDeck, corpTrash])

  runnerHand = new Monolith.Models.CardCollection([runnerHand1, runnerHand2, runnerHand3, runnerHand4, runnerHand5])
  corpHand = new Monolith.Models.CardCollection([corpHand1, corpHand2, corpHand3, corpHand4, corpHand5])

  # Tokens

  runnerCredits = new Monolith.Models.TokensModel(type: 'credit', amount: 5)
  corpCredits = new Monolith.Models.TokensModel(type: 'credit', amount: 15)
  corpBadPub = new Monolith.Models.TokensModel(type: 'bad-publicity', amount: 1)

  runnerTokens = new Monolith.Models.TokensCollection([runnerCredits])
  corpTokens = new Monolith.Models.TokensCollection([corpCredits, corpBadPub])

  # Build board

  runnerModel = new Monolith.Models.PlayerModel(type: 'runner', side: 'left', piles: runnerPiles, hand: runnerHand, tokens: runnerTokens)
  corpModel = new Monolith.Models.PlayerModel(type: 'corp', side: 'right', piles: corpPiles, hand: corpHand, tokens: corpTokens)

  runnerView = new Monolith.Views.PlayerView(model: runnerModel)
  corpView = new Monolith.Views.PlayerView(model: corpModel)

  if runnerModel.get('side') == 'left'
    Monolith.leftPlayRegion.show(runnerView)
    Monolith.rightPlayRegion.show(corpView)
  else
    Monolith.rightPlayRegion.show(runnerView)
    Monolith.leftPlayRegion.show(corpView)

  # Events

  $(window).trigger('resize') # fixes some issues with card sizes.
