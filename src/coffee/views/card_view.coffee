class App.Views.CardView extends Backbone.Marionette.ItemView
  template: _.template('')
  className: 'card'
  tagName: 'img'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'
  CARD_IMG_PATH = 'http://netrunnerdb.com/web/bundles/netrunnerdbcards/images/cards/en/'
  CARD_IMG_SUFFIX = '.png'

  modelEvents:
    'change:faceUp': 'render'

  events:
    'click': '_toggleFacing'

  onRender: ->
    if @model.get('faceUp')
      @$el.attr(src: @_cardImagePath())
    else
      @$el.attr(src: ASPECT_RATIO_IMG)

  _cardImagePath: ->
    CARD_IMG_PATH + @model.get('cardId') + CARD_IMG_SUFFIX

  _toggleFacing: ->
    @model.toggleFacing()