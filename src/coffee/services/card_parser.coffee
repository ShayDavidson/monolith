class App.Services.CardFinder

  constructor: ->
    $.getJSON 'http://netrunnerdb.com/api/cards/', (cards) =>
      @cards = {}
      _.each cards, (c) =>
        key = @cleanUp(c.title)
        @cards[key] = _.extend(c, key: key)

  cleanUp: (cardname) ->
    cardname.toLowerCase()

  find: (cardName) ->
    return if _.isEmpty(@cards)
    @cards[@cleanUp(cardName)]

  @find: (cardName) ->
    App.Services.CardFinder.singelton.find(cardName)


App.Services.CardFinder.singelton = new App.Services.CardFinder()