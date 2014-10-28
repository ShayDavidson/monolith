class Monolith.Views.PlayerView extends Backbone.Marionette.LayoutView
  className: 'player'
  template: '#player-view-template'

  regions:
    piles: '.piles-region'
    playerInfo: '.player-info-region'
    hand: '.hand-region'

  onRender: ->
    @$el.addClass(@model.get('type'))

    @piles.show(new Monolith.Views.PilesView(collection: @model.get('piles'), side: @model.get('side')))
    @playerInfo.show(new Monolith.Views.PlayerInfoView(model: @model))
    @hand.show(new Monolith.Views.HandView(collection: @model.get('hand')))