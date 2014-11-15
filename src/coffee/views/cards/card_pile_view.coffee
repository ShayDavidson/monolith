class Monolith.Views.CardPileView extends Backbone.Marionette.CollectionView
  className: 'row'
  template: '#row-view-template'
  childView: Monolith.Views.CardView

  ROW_CARD_OFFSET = 0.3
  BASE_WINDOW_HEIGHT = 750

  initialize: (options) ->
    @collection = options.model.get('cardsCollections')
    $(window).resize(=> @_setRowCardOffset())

  onShow: ->
    @_setRowCardOffset()

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
