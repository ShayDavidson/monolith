class App.Views.ZoomedCardView extends Backbone.Marionette.ItemView
  template: _.template('')
  className: 'card hidden'
  tagName: 'img'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'
  CARD_IMG_PATH = 'http://netrunnerdb.com/web/bundles/netrunnerdbcards/images/cards/en/'
  CARD_IMG_SUFFIX = '.png'
  ZOOM_TIMEOUT = 300

  onRender: ->
    if @model.get('faceUp')
      @$el.attr(src: @_cardImagePath())
    else
      @$el.attr(src: ASPECT_RATIO_IMG)

  onShow: ->
    setTimeout((=> @$el.removeClass('hidden')), 10)

  _cardImagePath: ->
    CARD_IMG_PATH + @model.get('cardId') + CARD_IMG_SUFFIX
