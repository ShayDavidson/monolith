class App.Views.PlayerView extends Backbone.Marionette.LayoutView
  className: 'player'
  template: '#player-view-template'

  regions:
    piles: '.piles-region'
    hand: '.hand-region'

  onRender: ->
    @$el.addClass(@model.get('side'))

    @piles.show(new App.Views.PilesView(collection: @model.get('piles')))
    @hand.show(new App.Views.HandView(collection: @model.get('hand')))