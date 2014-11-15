class Monolith.ViewModels.CardViewModel extends Backbone.Model
  defaults:
    cardId: null
    faceUp: false
    ice: false
    tokens: null

  CARD_IMG_PATH = 'http://netrunnerdb.com/web/bundles/netrunnerdbcards/images/cards/en/'
  CARD_IMG_SUFFIX = '.png'

  initialize: ->
    @preloadImage() if @get('cardId')
    @_determineDefaults()

  toggleFacing: ->
    @set('faceUp', !@get('faceUp')) if @get('known')

  imagePath: ->
    CARD_IMG_PATH + @get('cardId') + CARD_IMG_SUFFIX

  preloadImage: ->
    dfr = $.Deferred()
    image = new Image()
    image.src = @imagePath()
    image.addEventListener('load', dfr.resolve)
    dfr.promise()

  _determineDefaults: ->
    @set(faceUp: false) unless @has('cardId')



