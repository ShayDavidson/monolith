class Monolith.ViewModels.RowViewModel extends Backbone.Model
  defaults:
    cardsCollections: null

  initialize: ->
    @_transformToCollection('cardsCollections')

  _transformToCollection: (attr) ->
    @set(attr, new Backbone.Collection(@get(attr)))
