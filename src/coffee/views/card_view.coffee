class App.Views.CardView extends Backbone.Marionette.ItemView
  template: _.template('')
  className: 'card'
  tagName: 'img'

  ASPECT_RATIO_IMG = '/images/cards/aspect.png'
  CARD_IMG_PATH = 'http://netrunnerdb.com/web/bundles/netrunnerdbcards/images/cards/en/'
  CARD_IMG_SUFFIX = '.png'
  ZOOM_TIMEOUT = 300

  modelEvents:
    'change:faceUp': 'render'

  events:
    'click': '_toggleFacing'
    'mousedown': '_startCountingTimeForZoom'
    'mouseup': '_stopCountingTimeForZoom'

  onRender: ->
    if @model.get('faceUp')
      @$el.attr(src: @_cardImagePath())
    else
      @$el.attr(src: ASPECT_RATIO_IMG)

  # Helpers

  _cardImagePath: ->
    CARD_IMG_PATH + @model.get('cardId') + CARD_IMG_SUFFIX

  # Actions

  _toggleFacing: ->
    @model.toggleFacing() unless @isZooming

  # Zooming

  _startCountingTimeForZoom: ->
    return unless @model.get('faceUp')

    @zoomTimeoutId = setTimeout((=> @_zoomCard()), ZOOM_TIMEOUT)

  _stopCountingTimeForZoom: ->
    if @zoomTimeoutId
      clearTimeout(@zoomTimeoutId)
      @zoomTimeoutId = undefined

  _zoomCard: ->
    @isZooming = true
    App.zoomedCardRegion.show(new App.Views.ZoomedCardView(model: @model))