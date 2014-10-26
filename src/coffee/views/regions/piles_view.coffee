class App.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: '#pile-view-template'
  childView: App.Views.CardView

  initialize: (options) ->
    @collection = options.model.get('cards')


class App.Views.PilesView extends Backbone.Marionette.CollectionView
  className: 'piles'
  childView: App.Views.PileView
  childViewOptions: (pile) ->
    collection: pile.get('cards')
