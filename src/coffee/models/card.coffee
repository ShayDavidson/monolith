class Monolith.Models.Card extends Backbone.Model

  hostedCards: ->
    @set('hostedCards', new Monolith.Models.Cards()) unless @has('hostedCards')
    @get('hostedCards')

  toJSON: ->
    attributes = super
    _.pick(attributes,[
        'title'
        'type'
        'subtype'
        'faction'
        'imagesrc'
        'hostedCards'
    ])

class Monolith.Models.Cards extends Backbone.Collection
  model: Monolith.Models.Card