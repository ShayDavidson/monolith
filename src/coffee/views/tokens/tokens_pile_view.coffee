class App.Views.TokensPileView extends Backbone.Marionette.CollectionView
  className: 'tokens-collection'
  childView: App.Views.TokenView

  onRender: ->