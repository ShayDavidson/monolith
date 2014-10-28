Backbone.Marionette.Renderer.render = (template = 'none') ->
  if template != 'none'
    _.template($(template).html())
  else
    (-> '')
