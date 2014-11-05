class App.Models.Player extends Backbone.Model

#  defaults:
#    credits: null
#    hand: null

  setIdentity: (identity) ->
    @set('identity', identity)

  stack: ->
    @set('stack', new App.Models.Cards()) unless @has('stack')
    @get('stack')

  scored: ->
    @set('scored', new App.Models.Cards()) unless @has('scored')
    @get('scored')

  grip: ->
    @set('grip', new App.Models.Cards()) unless @has('grip')
    @get('grip')

  installed: ->
    @set('installed', new App.Models.Cards()) unless @has('installed')
    @get('installed')

  heap: ->
    @set('heap', new App.Models.Cards()) unless @has('heap')
    @get('heap')
