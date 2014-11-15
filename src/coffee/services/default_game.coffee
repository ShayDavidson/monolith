class Monolith.Services.DefaultGame

  @generate: ->

    # Corp

    corpId    = @faceUpCard('04097', faceUp: true) # GRNDL
    corpHand1 = @faceUpCard('01086', faceUp: true) # SEA Source
    corpHand2 = @faceUpCard('01110', faceUp: true) # Hedge Fund
    corpHand3 = @faceUpCard('01099', faceUp: true) # Scorched Earth
    corpHand4 = @faceUpCard('01099', faceUp: true) # Scorched Earth
    corpHand5 = @faceUpCard('01090', faceUp: true) # Tollbooth
    corpTrash = @faceUpCard('04040', faceUp: true) # Restructure
    corpIce1  = @faceUpCard('01090', ice: true, faceUp: true) # Tollbooth
    corpIce2  = @faceUpCard('02110', ice: true, faceUp: true) # Eli 1.0
    corpIce3  = @faceDownCard(ice: true)

    # Runner

    runnerId    = @faceUpCard('03028', faceUp: true) # Kit
    runnerHand1 = @faceUpCard('04109', faceUp: true) # Lucky Find
    runnerHand2 = @faceUpCard('02047', faceUp: true) # Test Run
    runnerHand3 = @faceUpCard('04047', faceUp: true) # Torch
    runnerHand4 = @faceUpCard('01034', faceUp: true) # Diesel
    runnerCard1 = @faceUpCard('03036', faceUp: true) # Monolith
    runnerCard2 = @faceUpCard('02091', faceUp: true, tokens: @tokensCollection([@tokens('credits', 3)])) # Kati Jones

    # Decks

    decksArray = []
    _.times(30, => decksArray.push(@faceDownCard()))

    # Rows

    runnerMainRow = @row([decksArray, runnerCard1])
    runnerIdRow   = @row([runnerId])
    runnerTempRow = @row([runnerCard2])
    runnerRows    = @rows([runnerTempRow, runnerIdRow, runnerMainRow, @row()])

    corpMainRow  = @row([decksArray, corpIce1, corpIce2])
    corpIdRow    = @row([corpId])
    corpArchives = @row([corpTrash])
    corpRows     = @rows([@row(), corpIdRow, corpMainRow, corpArchives])

    # Hands

    runnerHand = @cards([runnerHand1, runnerHand2, runnerHand3, runnerHand4])
    corpHand   = @cards([corpHand1, corpHand2, corpHand3, corpHand4, corpHand5])

    # Tokens

    runnerCredits  = @tokens('credit', 5)
    runnerBrainDmg = @tokens('brain-damage', 3)
    runnerTags     = @tokens('tag', 3)
    runnerTokens   = @tokensCollection([runnerCredits, runnerTags, runnerBrainDmg])

    corpCredits = @tokens('credit', 7)
    corpBadPub  = @tokens('bad-publicity', 1)
    corpTokens  = @tokensCollection([corpCredits, corpBadPub])

    # Board

    runnerModel = @player('runner', 'left',  runnerRows, runnerHand, runnerTokens)
    corpModel   = @player('corp',   'right', corpRows,   corpHand,   corpTokens)
    currentCard = @faceUpCard('06034') # Scrubbed

    game = @game(runner: runnerModel, corp: corpModel, current: currentCard)

  # Helpers

  @game: (options) ->
    new Monolith.ViewModels.GameViewModel(options)

  @row: (piles = []) ->
    new Monolith.ViewModels.RowViewModel(cardPiles: new Backbone.Collection(piles))

  @rows: (rows) ->
    new Backbone.Collection(rows)

  @cards: (cards) ->
    new Backbone.Collection(cards)

  @faceUpCard: (id, options = {}) ->
    options.cardId = id
    options.faceUp = true
    new Monolith.ViewModels.CardViewModel(options)

  @faceDownCard: (options = {}) ->
    new Monolith.ViewModels.CardViewModel(options)

  @player: (type, side, rows, hand, tokens) ->
    new Monolith.ViewModels.PlayerViewModel(type: type, side: side, rows: rows, hand: hand, tokens: tokens)

  @tokens: (type, amount) ->
    new Monolith.ViewModels.TokensViewModel(type: type, amount: amount)

  @tokensCollection: (tokens) ->
    new Monolith.ViewModels.TokensViewCollection(tokens)

  @cardPile: (pileArray) ->
    new Monolith.ViewModels.CardPileViewModel(cards: pileArray)