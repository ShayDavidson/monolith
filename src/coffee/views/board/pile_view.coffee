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
    @$el.css(width: @$el.height() * Monolith.Views.CardView.CARD_ASPECT_RATIO)

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
