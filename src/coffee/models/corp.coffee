class Monolith.Models.Corp extends Backbone.Model

  defaults:
    credits: 0
    badPublicity: 0

  setIdentity: (identity) ->
    @set('identity', identity)

  rnd: ->
    @set('rnd', new Monolith.Models.Server()) unless @has('rnd')
    @get('rnd')

  hq: ->
    @set('hq', new Monolith.Models.Server()) unless @has('hq')
    @get('hq')

  archives: ->
    @set('archives', new Monolith.Models.Server()) unless @has('archives')
    @get('archives')

  remotes: ->
    @set('remotes', new Monolith.Models.Servers()) unless @has('remotes')
    @get('remotes')

  scored: ->
    @set('scored', new Monolith.Models.Cards()) unless @has('scored')
    @get('scored')
