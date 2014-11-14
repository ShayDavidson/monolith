class Monolith.ViewModels.GameViewModel extends Backbone.Model
  defaults:
    runner: null
    corp: null
    current: null

  isRunnerOnLeft: ->
    @get('runner').get('side') == 'left'

  @defaultGame: ->
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

    # Rows

    decksArray = []
    _.times(30, -> decksArray.push(new Monolith.ViewModels.CardViewModel()))

    noCards = new Monolith.ViewModels.CardViewCollection()
    firstNoCardsRow = new Monolith.ViewModels.RowViewModel(cards: noCards)
    lastNoCardsRow = new Monolith.ViewModels.RowViewModel(cards: noCards)

    runnerDeck = new Monolith.ViewModels.RowViewModel(cards: new Monolith.ViewModels.CardViewCollection(decksArray))
    corpDeck = new Monolith.ViewModels.RowViewModel(cards: new Monolith.ViewModels.CardViewCollection(decksArray))

    runnerIdRow = new Monolith.ViewModels.RowViewModel(cards: new Monolith.ViewModels.CardViewCollection([runnerId]))
    corpIdRow = new Monolith.ViewModels.RowViewModel(cards: new Monolith.ViewModels.CardViewCollection([corpId]))

    corpTrash = new Monolith.ViewModels.RowViewModel(cards: new Monolith.ViewModels.CardViewCollection([corpTrash1]))

    runnerTempRow = new Monolith.ViewModels.RowViewModel(cards: new Monolith.ViewModels.CardViewCollection([runnerResource]))

    runnerRows = new Monolith.ViewModels.RowViewCollection([runnerTempRow, runnerIdRow, runnerDeck, lastNoCardsRow])
    corpRows = new Monolith.ViewModels.RowViewCollection([firstNoCardsRow, corpIdRow, corpDeck, corpTrash])

    runnerHand = new Monolith.ViewModels.CardViewCollection([runnerHand1, runnerHand2, runnerHand3, runnerHand4])
    corpHand = new Monolith.ViewModels.CardViewCollection([corpHand1, corpHand2, corpHand3, corpHand4, corpHand5])

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
      runner: runnerModel,
      corp: corpModel,
      current: currentCard
    )

