class App.Models.Player extends Backbone.Model

#  defaults:
#    credits: null
#    hand: null


  grip: ->
    @set('grip', new App.Models.Cards()) unless @has('grip')
    @get('grip')

  installed: ->
    @set('installed', new App.Models.Cards()) unless @has('installed')
    @get('installed')

  heap: ->
    @set('heap', new App.Models.Cards()) unless @has('heap')
    @get('heap')