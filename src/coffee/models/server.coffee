class Monolith.Models.Server extends Backbone.Model
  defaults: ->
    installed: new Monolith.Models.Cards()
    ice: new Monolith.Models.Cards()

class Monolith.Models.Servers extends Backbone.Collection
  model: Monolith.Models.Server
