class App.Models.Game extends Backbone.Model

  defaults:
    corp: null
    runner: null


  runner: ->
    @set('runner', new App.Models.Player()) unless @has('runner')
    @get('runner')

  corp: ->
    @set('corp', new App.Models.Player()) unless @has('corp')
    @get('corp')