class Monolith.Models.CardCollection extends Backbone.Collection
  model: Monolith.Models.CardModel

class Monolith.Models.CardModel extends Backbone.Model
  defaults:
    cardId: null
    faceUp: false
    known: true

  CARD_IMG_PATH = 'http://netrunnerdb.com/web/bundles/netrunnerdbcards/images/cards/en/'
  CARD_IMG_SUFFIX = '.png'

  initialize: ->
    @preloadImage()

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



