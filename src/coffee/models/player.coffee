class Monolith.Models.Player extends Backbone.Model

  defaults:
    credits: 0
    tags: 0
    brainDamage: 0
    badPublicity: 0

  setIdentity: (identity) ->
    @set('identity', identity)

  stack: ->
    @set('stack', new Monolith.Models.Cards()) unless @has('stack')
    @get('stack')

  scored: ->
    @set('scored', new Monolith.Models.Cards()) unless @has('scored')
    @get('scored')

  grip: ->
    @set('grip', new Monolith.Models.Cards()) unless @has('grip')
    @get('grip')

  installed: ->
    @set('installed', new Monolith.Models.Cards()) unless @has('installed')
    @get('installed')

  heap: ->
    @set('heap', new Monolith.Models.Cards()) unless @has('heap')
    @get('heap')
