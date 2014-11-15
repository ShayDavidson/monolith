Monolith.generateDefaultGame = ->

  # Corp

  corpId    = new Monolith.ViewModels.CardViewModel(cardId: '04097', faceUp: true) # GRNDL
  corpHand1 = new Monolith.ViewModels.CardViewModel(cardId: '01086', faceUp: true) # SEA Source
  corpHand2 = new Monolith.ViewModels.CardViewModel(cardId: '01110', faceUp: true) # Hedge Fund
  corpHand3 = new Monolith.ViewModels.CardViewModel(cardId: '01099', faceUp: true) # Scorched Earth
  corpHand4 = new Monolith.ViewModels.CardViewModel(cardId: '01099', faceUp: true) # Scorched Earth
  corpHand5 = new Monolith.ViewModels.CardViewModel(cardId: '01090', faceUp: true) # Tollbooth
  corpTrash1 = new Monolith.ViewModels.CardViewModel(cardId: '04040', faceUp: true) # Restructure
  corpIce1 = new Monolith.ViewModels.CardViewModel(cardId: '01090', ice: true, faceUp: true) # Tollbooth
  corpIce2 = new Monolith.ViewModels.CardViewModel(cardId: '02110', ice: true, faceUp: true) # Eli 1.0
  corpIce3 = new Monolith.ViewModels.CardViewModel(ice: true)

  # Runner

  runnerId    = new Monolith.ViewModels.CardViewModel(cardId: '03028', faceUp: true) # Kit
  runnerHand1 = new Monolith.ViewModels.CardViewModel(cardId: '04109', faceUp: true) # Lucky Find
  runnerHand2 = new Monolith.ViewModels.CardViewModel(cardId: '02047', faceUp: true) # Test Run
  runnerHand3 = new Monolith.ViewModels.CardViewModel(cardId: '04047', faceUp: true) # Torch
  runnerHand4 = new Monolith.ViewModels.CardViewModel(cardId: '01034', faceUp: true) # Diesel
  runnerResourceTokens = new Monolith.ViewModels.TokensViewCollection([new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: 3)])
  runnerResource = new Monolith.ViewModels.CardViewModel(cardId: '02091', faceUp: true, tokens: runnerResourceTokens) # Kati Jones
  runnerHardware = new Monolith.ViewModels.CardViewModel(cardId: '03036', faceUp: true) # Monolith

  # Rows

  decksArray = []
  _.times(30, -> decksArray.push(new Monolith.ViewModels.CardViewModel()))

  noCards = []
  firstNoCardsRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection(noCards))
  lastNoCardsRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection(noCards))

  runnerMainRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([decksArray, runnerHardware]))
  corpMainRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([decksArray, corpIce1, corpIce2]))

  runnerIdRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([runnerId]))
  corpIdRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([corpId]))

  corpTrash = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([corpTrash1]))

  runnerTempRow = new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection([runnerResource]))

  runnerRows = new Backbone.Collection([runnerTempRow, runnerIdRow, runnerMainRow, lastNoCardsRow])
  corpRows = new Backbone.Collection([firstNoCardsRow, corpIdRow, corpMainRow, corpTrash])

  runnerHand = new Backbone.Collection([runnerHand1, runnerHand2, runnerHand3, runnerHand4])
  corpHand = new Backbone.Collection([corpHand1, corpHand2, corpHand3, corpHand4, corpHand5])

  # Tokens

  runnerCredits = new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: 5)
  runnerBrainDmg = new Monolith.ViewModels.TokensViewModel(type: 'brain-damage', amount: 3)
  runnerTags = new Monolith.ViewModels.TokensViewModel(type: 'tag', amount: 3)
  corpCredits = new Monolith.ViewModels.TokensViewModel(type: 'credit', amount: 15)
  corpBadPub = new Monolith.ViewModels.TokensViewModel(type: 'bad-publicity', amount: 3)

  runnerTokens = new Monolith.ViewModels.TokensViewCollection([runnerCredits, runnerTags, runnerBrainDmg])
  corpTokens = new Monolith.ViewModels.TokensViewCollection([corpCredits, corpBadPub])

  # Build board

  runnerModel = new Monolith.ViewModels.PlayerViewModel(type: 'runner', side: 'left', rows: runnerRows, hand: runnerHand, tokens: runnerTokens)
  corpModel = new Monolith.ViewModels.PlayerViewModel(type: 'corp', side: 'right', rows: corpRows, hand: corpHand, tokens: corpTokens)
  currentCard = new Monolith.ViewModels.CardViewModel(cardId: '06034', faceUp: true) # Scrubbed

  game = new Monolith.ViewModels.GameViewModel(
    runner:  runnerModel,
    corp:    corpModel,
    current: currentCard
  )