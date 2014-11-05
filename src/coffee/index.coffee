window.Monolith = new Backbone.Marionette.Application()

Monolith.ViewModels = {}
Monolith.Views = {}

$ ->

  # Regions

  Monolith.addRegions
    currentRegion: '.current-region'
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'
    zoomedCardRegion: '.zoomed-card-container'

  # Cards

  ## Corp

  corpId    = new Monolith.ViewModels.CardViewModel(cardId: '04097', faceUp: true) # GRNDL
  corpHand1 = new Monolith.ViewModels.CardViewModel(cardId: '01086', faceUp: true) # SEA Source
  corpHand2 = new Monolith.ViewModels.CardViewModel(cardId: '01110', faceUp: true) # Hedge Fund
  corpHand3 = new Monolith.ViewModels.CardViewModel(cardId: '01099', faceUp: true) # Scorched Earth
  corpHand4 = new Monolith.ViewModels.CardViewModel(cardId: '01099', faceUp: true) # Scorched Earth
  corpHand5 = new Monolith.ViewModels.CardViewModel(cardId: '01090', faceUp: true) # Tollbooth

  corpTrash1 = new Monolith.ViewModels.CardViewModel(cardId: '04040', faceUp: true) # Restructure

  ## Runner

  runnerId    = new Monolith.ViewModels.CardViewModel(cardId: '03028', faceUp: true) # Kit
  runnerHand1 = new Monolith.ViewModels.CardViewModel(cardId: '04109', faceUp: true) # Lucky Find
  runnerHand2 = new Monolith.ViewModels.CardViewModel(cardId: '02047', faceUp: true) # Test Run
  runnerHand3 = new Monolith.ViewModels.CardViewModel(cardId: '04047', faceUp: true) # Torch
  runnerHand4 = new Monolith.ViewModels.CardViewModel(cardId: '01034', faceUp: true) # Diesel

  runnerResourceTokens = new Monolith.ViewModels.TokensViewCollection([new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: 3)])
  runnerResource = new Monolith.ViewModels.CardViewModel(cardId: '02091', faceUp: true, tokens: runnerResourceTokens) # Kati Jones

  # Piles

  decksArray = []
  _.times(30, -> decksArray.push(new Monolith.ViewModels.CardViewModel()))

  noCards = new Monolith.ViewModels.CardViewCollection()
  firstNoCardsPile = new Monolith.ViewModels.PileViewModel(cards: noCards)
  lastNoCardsPile = new Monolith.ViewModels.PileViewModel(cards: noCards)

  runnerDeck = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection(decksArray))
  corpDeck = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection(decksArray))

  runnerIdPile = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection([runnerId]))
  corpIdPile = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection([corpId]))

  corpTrash = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection([corpTrash1]))

  runnerTempPile = new Monolith.ViewModels.PileViewModel(cards: new Monolith.ViewModels.CardViewCollection([runnerResource]))

  runnerPiles = new Monolith.ViewModels.PileViewCollection([runnerTempPile, runnerIdPile, runnerDeck, lastNoCardsPile])
  corpPiles = new Monolith.ViewModels.PileViewCollection([firstNoCardsPile, corpIdPile, corpDeck, corpTrash])

  runnerHand = new Monolith.ViewModels.CardViewCollection([runnerHand1, runnerHand2, runnerHand3, runnerHand4])
  corpHand = new Monolith.ViewModels.CardViewCollection([corpHand1, corpHand2, corpHand3, corpHand4, corpHand5])

  # Tokens

  runnerCredits = new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: 3)
  corpCredits = new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: 15)
  corpBadPub = new Monolith.ViewModels.TokensViewModel(type: 'bad-publicity', amount: 1)

  runnerTokens = new Monolith.ViewModels.TokensViewCollection([runnerCredits])
  corpTokens = new Monolith.ViewModels.TokensViewCollection([corpCredits, corpBadPub])

  # Build board

  runnerModel = new Monolith.ViewModels.PlayerViewModel(type: 'runner', side: 'left', piles: runnerPiles, hand: runnerHand, tokens: runnerTokens)
  corpModel = new Monolith.ViewModels.PlayerViewModel(type: 'corp', side: 'right', piles: corpPiles, hand: corpHand, tokens: corpTokens)

  runnerView = new Monolith.Views.PlayerView(model: runnerModel)
  corpView = new Monolith.Views.PlayerView(model: corpModel)

  if runnerModel.get('side') == 'left'
    Monolith.leftPlayRegion.show(runnerView)
    Monolith.rightPlayRegion.show(corpView)
  else
    Monolith.rightPlayRegion.show(runnerView)
    Monolith.leftPlayRegion.show(corpView)

  currentCard = new Monolith.ViewModels.CardViewModel(cardId: '06034', faceUp: true) # Scrubbed
  Monolith.currentRegion.show(new Monolith.Views.CardView(model: currentCard))

  # Events

  $(window).trigger('resize') # fixes some issues with card sizes.
