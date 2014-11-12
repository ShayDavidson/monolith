class Monolith.Models.Game extends Backbone.Model

  defaults:
    corp: null
    runner: null
    current: null

  runner: ->
    @set('runner', new Monolith.Models.Player()) unless @has('runner')
    @get('runner')

  corp: ->
    @set('corp', new Monolith.Models.Player()) unless @has('corp')
    @get('corp')