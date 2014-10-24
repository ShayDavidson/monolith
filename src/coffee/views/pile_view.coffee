class App.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: '#pile-view-template'
  childView: App.Views.CardView

  initialize: (options) ->
    @collection = options.model.get('cards')
