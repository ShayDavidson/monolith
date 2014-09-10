class App.Models.Card extends Backbone.Model

  hostedCards: ->
    @set('hostedCards', new App.Models.Cards()) unless @has('hostedCards')
    @get('hostedCards')

class App.Models.Cards extends Backbone.Collection
  model: App.Models.Card