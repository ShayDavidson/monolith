class Monolith.Views.TokenView extends Backbone.Marionette.ItemView
  className: 'token'

class Monolith.Views.TokensPileView extends Backbone.Marionette.ItemView
  template: false
  className: 'tokens-pile'

  TOKEN_TEMPLATE =  $('#token-view-template').html()
  ROTATION_RANDOM_RANGE = 40

  onRender: ->
    @_renderTokens()

  _renderTokens: ->
    _.times(@model.get('amount'), (index) =>
      @$el.append(@_createTokenElement(index))
    )

  _createTokenElement: (index) ->
    position = @model.positionForIndex[index]
    tokenEl = $(TOKEN_TEMPLATE)
    tokenEl.attr(src: @model.imagePath())
    tokenEl.css(top: "#{position.top}%", left: "#{position.left}%")
    tokenEl.addClass("random-transform-#{Math.floor(Math.random() * ROTATION_RANDOM_RANGE)}")
    tokenEl.addClass(@model.get('type'))
