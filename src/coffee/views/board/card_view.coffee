class Monolith.Views.CardView extends Monolith.Views.BaseCardView

  @CARD_ASPECT_RATIO = 0.706

  modelEvents:
    'change:faceUp': 'render'

  events:
    'mousedown': '_zoomCard'
    'mouseup': '_stopZooming'
    'mouseout': '_stopZooming'
    'mouseover': '_checkZooming'

  # Marionette methods

  initialize: ->
    $(window).resize(=> @_setAspectRatio())

  # Helpers

  _setAspectRatio: ->
    @$el.css(width: @$el.height() * @constructor.CARD_ASPECT_RATIO)

  # Zooming

  _canZoom: ->
    @model.has('cardId')

  _zoomCard: ->
    return unless @_canZoom()
    
    @isZooming = true
    @zoomedCard = new Monolith.Views.BaseCardView(model: @model)
    Monolith.zoomedCardRegion.show(@zoomedCard)

  _checkZooming: ->
    @_zoomCard() if Monolith.Input.isMouseDown && !@isZooming

  _stopZooming: ->
    if @isZooming
      @zoomedCard.destroy()
      @isZooming = false
