class Monolith.ViewModels.PlayerViewModel extends Backbone.Model

  defaults:
    type: null # 'corp' or 'runner'
    side: null # 'left' or 'right'
    rows: null
    hand: null
    tokens: null
    credits: 0
    badPublicity: 0
    tags: 0

  initialize: ->
    @set('rows', new Backbone.Collection(@get('rows')))
