class Monolith.Views.PlayerInfoView extends Backbone.Marionette.LayoutView
  template: '#player-info-view-template'
  className: 'player-info'

  regions:
    credits: '.credits-region'

  onRender: ->
    @credits.show(new Monolith.Views.TokensPileView(type: 'credits', amount: @model.get('credits')))