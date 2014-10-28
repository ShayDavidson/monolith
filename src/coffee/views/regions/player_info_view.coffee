class Monolith.Views.PlayerInfoView extends Backbone.Marionette.LayoutView
  template: '#player-info-view-template'
  className: 'player-info'

  regions:
    credits: '.credits-region'

  onRender: ->
    creditsModel = new Monolith.Models.TokensModel(type: 'credits', amount: @model.get('credits'))
    @credits.show(new Monolith.Views.TokensPileView(creditsModel))