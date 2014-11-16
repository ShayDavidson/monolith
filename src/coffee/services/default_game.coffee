class Monolith.Services.DefaultGame

  @generate: ->

    # Corp

    corpId    = @faceUpCard('04097') # GRNDL
    corpHand1 = @faceUpCard('01086') # SEA Source
    corpHand2 = @faceUpCard('01110') # Hedge Fund
    corpHand3 = @faceUpCard('01099') # Scorched Earth
    corpHand4 = @faceUpCard('01099') # Scorched Earth
    corpHand5 = @faceUpCard('01090') # Tollbooth
    corpTrash = @faceUpCard('04040') # Restructure
    corpIce1  = @faceUpCard('02110', ice: true) # Eli 1.0
    corpIce2  = @faceDownCard(cardId: '01090', ice: true) # Tollbooth
    corpIce3  = @faceDownCard(ice: true)

    # Runner

    runnerId    = @faceUpCard('03028') # Kit
    runnerHand1 = @faceUpCard('04109') # Lucky Find
    runnerHand2 = @faceUpCard('02047') # Test Run
    runnerHand3 = @faceUpCard('04047') # Torch
    runnerHand4 = @faceUpCard('01034') # Diesel
    runnerCard1 = @faceUpCard('03036') # Monolith
    runnerCard2 = @faceUpCard('02089') # Creeper
    runnerCard3 = @faceUpCard('02091', tokens: @tokensCollection([@tokens('credit', 3)])) # Kati Jones

    # Decks

    decksArray = []
    _.times(40, => decksArray.push(@faceDownCard()))

    # Rows

    runnerMainRow = @row([decksArray])
    runnerIdRow   = @row([runnerId, runnerCard1, runnerCard2])
    runnerTempRow = @row([runnerCard3])
    runnerRows    = @rows([runnerTempRow, runnerIdRow, runnerMainRow, @row()])

    corpMainRow  = @row([decksArray, corpIce1, corpIce2])
    corpIdRow    = @row([corpId])
    corpArchives = @row([corpTrash, corpIce3])
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
    piles = _.map(piles, (cards) ->
      cards = [cards] unless _.isArray(cards)
      new Monolith.ViewModels.PileViewModel(cards: new Backbone.Collection(cards))
    )
    new Monolith.ViewModels.RowViewModel(piles: new Backbone.Collection(piles))

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