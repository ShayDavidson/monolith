class Monolith.Views.TokensPileView extends Backbone.Marionette.CollectionView
  className: 'tokens-collection'
  childView: Monolith.Views.TokenView

  onRender: ->