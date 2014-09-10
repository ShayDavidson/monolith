class App.Models.Player extends Backbone.Model

#  defaults:
#    credits: null
#    hand: null


  grip: ->
    @set('grip', new App.Models.Cards()) unless @has('grip')
    @get('grip')