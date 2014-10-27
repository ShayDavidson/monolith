class Monolith.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: '#pile-view-template'
  childView: Monolith.Views.CardView

  PILE_CARD_OFFSET = 0.5

  initialize: (options) ->
    @collection = options.model.get('cards')

  onRender: ->
    @children.each((cardView, index) ->
      offset = index * PILE_CARD_OFFSET
      cardView.$el.css(top: "#{offset}px", left: "#{offset}px")
    )


class Monolith.Views.PilesView extends Backbone.Marionette.CollectionView
  className: 'piles'
  childView: Monolith.Views.PileView
  childViewOptions: (pile) ->
    collection: pile.get('cards')
