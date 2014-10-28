class Monolith.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: '#pile-view-template'
  childView: Monolith.Views.CardView

  PILE_CARD_OFFSET = 0.3
  BASE_WINDOW_HEIGHT = 750

  initialize: (options) ->
    @collection = options.model.get('cards')
    $(window).resize(=> @_setPileCardOffset())

  onShow: ->
    @_setPileCardOffset()

  _setPileCardOffset: ->
    @children.each((cardView, index) ->
      heightRatio = $(window).height() / BASE_WINDOW_HEIGHT
      offset = "#{index * PILE_CARD_OFFSET * heightRatio}px"
      cardView.$el.css('margin-top': offset)
      if cardView.$el.parents('.left')
        cardView.$el.css('margin-left': offset)
      else
        cardView.$el.css('margin-right': offset)
    )


class Monolith.Views.PilesView extends Backbone.Marionette.CollectionView
  className: 'piles'
  childView: Monolith.Views.PileView
  childViewOptions: (pile) ->
    collection: pile.get('cards')

  BASE_Z_INDEX = 2000

  onRender: ->
    count = @children.length
    @children.each((pileView, index) ->
      pileView.$el.css('z-index': BASE_Z_INDEX + count - index)
    )
