class Monolith.ViewModels.GameViewModel extends Backbone.Model
  defaults:
    runner:  null
    corp:    null
    current: null

  isRunnerOnLeft: ->
    @get('runner').get('side') == 'left'