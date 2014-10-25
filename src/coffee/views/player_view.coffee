class App.Views.PlayerView extends Backbone.Marionette.LayoutView
  className: 'player'
  template: '#player-view-template'

  regions:
    piles: '.piles-region'
    playerInfo: '.player-info-region'
    hand: '.hand-region'

  onRender: ->
    @$el.addClass(@model.get('side'))

    @piles.show(new App.Views.PilesView(collection: @model.get('piles')))
    @playerInfo.show(new App.Views.PlayerInfoView(model: @model))
    @hand.show(new App.Views.HandView(collection: @model.get('hand')))