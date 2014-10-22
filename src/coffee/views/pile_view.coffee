class App.Views.PileView extends Backbone.Marionette.CollectionView
  className: 'pile'
  template: _.template($('#pile-view-template').html())
  childView: App.Views.CardView

  initialize: (options) ->
    @collection = options.model.get('cards')
