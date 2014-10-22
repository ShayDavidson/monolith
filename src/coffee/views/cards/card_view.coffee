class App.Views.CardView extends App.Views.BaseCardView

  ZOOM_TIMEOUT = 150

  modelEvents:
    'change:faceUp': 'render'

  events:
    'click': '_toggleFacing'
    'mousedown': '_startCountingTimeForZoom'
    'mouseup': '_stopCountingTimeForZoom'
    'mouseout': '_stopZooming'

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
    @zoomedCard = new App.Views.ZoomedCardView(model: @model)
    App.zoomedCardRegion.show(@zoomedCard)

  _stopZooming: ->
    if @isZooming
      @zoomedCard.hide()
      @isZooming = false