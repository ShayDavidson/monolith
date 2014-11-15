class Monolith.ViewModels.RowViewModel extends Backbone.Model
  defaults:
    cards: null

  initialize: ->
    @_transformToCollection('cards')

  _transformToCollection: (attr) ->
    @set(attr, new Backbone.Collection(@get(attr)))
