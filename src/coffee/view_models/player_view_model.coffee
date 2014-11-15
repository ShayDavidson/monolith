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
    @_transformToCollection('rows')
    @_transformToCollection('hand')

  _transformToCollection: (attr) ->
    @set(attr, new Backbone.Collection(@get(attr)))
