class Monolith.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  childView: Monolith.Views.CardView

  ROW_CARD_OFFSET = 0.3
  BASE_WINDOW_HEIGHT = 750

  initialize: (options) ->
    $(window).resize(=>
      @_setAspectRatio()
      @_setRowCardOffset()
    )

  onRender: ->
    if @model.get('icePile')
      @$el.addClass('ice')
    else
      @$el.addClass('non-ice')

  onShow: ->
    @_setRowCardOffset()

  _setAspectRatio: ->
    if @model.get('icePile')
      width = @$el.height() * Monolith.Views.CardView.CARD_ASPECT_RATIO
    else
      width = @$el.height()
    @$el.css(width: width)

  _setRowCardOffset: ->
    side = @options.side
    @children.each((cardView, index) ->
      heightRatio = $(window).height() / BASE_WINDOW_HEIGHT
      offset = "#{index * ROW_CARD_OFFSET * heightRatio}px"
      cardView.$el.css('margin-top': offset)
      if side == 'left'
        cardView.$el.css('margin-left': offset)
      else
        cardView.$el.css('margin-right': offset)
    )
