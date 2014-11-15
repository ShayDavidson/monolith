class Monolith.ViewModels.PileViewModel extends Backbone.Model
  defaults:
    cards: new Backbone.Collection([])
    icePile: false

  initialize: ->
    @set('icePile', @get('cards').findWhere(ice: true) != undefined)