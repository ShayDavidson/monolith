class Monolith.Views.CardView extends Monolith.Views.BaseCardView

  CARD_ASPECT_RATIO = 0.706
  ZOOM_TIMEOUT = 150

  modelEvents:
    'change:faceUp': 'render'

  events:
    'click': '_toggleFacing'
    'mousedown': '_startCountingTimeForZoom'
    'mouseup': '_stopCountingTimeForZoom'
    'mouseout': '_stopZooming'

  # Marionette methods

  initialize: ->
    $(window).resize(=> @_setAspectRatio())

  # Helpers

  _setAspectRatio: ->
    @$el.css(width: @$el.height() * CARD_ASPECT_RATIO)

  # Actions

  _toggleFacing: ->
    if @isZooming
      @_stopZooming()
    else
      @model.toggleFacing()

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
    @zoomedCard = new Monolith.Views.ZoomedCardView(model: @model)
    Monolith.zoomedCardRegion.show(@zoomedCard)

  _stopZooming: ->
    if @isZooming
      @zoomedCard.hide()
      @isZooming = false
