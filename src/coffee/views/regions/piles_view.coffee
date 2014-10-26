class Monolith.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: '#pile-view-template'
  childView: Monolith.Views.CardView

  initialize: (options) ->
    @collection = options.model.get('cards')


class Monolith.Views.PilesView extends Backbone.Marionette.CollectionView
  className: 'piles'
  childView: Monolith.Views.PileView
  childViewOptions: (pile) ->
    collection: pile.get('cards')
