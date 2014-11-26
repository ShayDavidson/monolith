class Monolith.Views.CardsFanView extends Backbone.Marionette.CollectionView
  childView: Monolith.Views.CardView

  ROTATION_CLASS_PREFIX = 'card-rotation'

  onRender: ->
    @_setCardRotations()

  _setCardRotations: ->
    angleDiff = 90 / (@children.length + 1)
    @children.each((cardView, index) ->
      angle = Math.floor(angleDiff * (index + 1))
      cardView.$el.addClass("#{ROTATION_CLASS_PREFIX}-#{angle}")
    )