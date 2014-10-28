class Monolith.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: '#pile-view-template'
  childView: Monolith.Views.CardView

  PILE_CARD_OFFSET = 0.25

  initialize: (options) ->
    @collection = options.model.get('cards')

  onShow: ->
    @children.each((cardView, index) ->
      offset = "#{index * PILE_CARD_OFFSET}px"
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
