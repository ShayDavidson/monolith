class Monolith.Services.CardFinder

  constructor: ->
    $.getJSON 'http://netrunnerdb.com/api/cards/', (cards) =>
      @cards = {}
      @identities = {}
      _.each cards, (c) =>
        key = @cleanUp(c.title)
        @cards[key] = _.extend(c, key: key)
        if c.type_code == 'identity'
          @identities[key] = _.extend(c, key: key)

  cleanUp: (cardname) ->
    cardname.toLowerCase()

  find: (cardName) ->
    return if _.isEmpty(@cards)
    @cards[@cleanUp(cardName)]

  findIdentity: (cardName) ->
    return if _.isEmpty(@identities)
    name = @cleanUp(cardName)
    _.find(_.values(@identities), (c) ->
      c.title.toLowerCase().indexOf(name) >= 0
    )

  @find: (cardName) ->
    Monolith.Services.CardFinder.singelton.find(cardName)

  @findIdentity: (cardName) ->
    Monolith.Services.CardFinder.singelton.findIdentity(cardName)


Monolith.Services.CardFinder.singelton = new Monolith.Services.CardFinder()