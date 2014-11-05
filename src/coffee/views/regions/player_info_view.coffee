class Monolith.Views.PlayerInfoView extends Backbone.Marionette.LayoutView
  template: '#player-info-view-template'
  className: 'player-info'

  regions:
    credits: '.credits-region'
    tagsAndBadPub: '.tags-bp-region'

  onRender: ->
    @_renderCredits()
    @_renderTagsOrBadPub()

  _renderCredits: ->
    @credits.show(new Monolith.Views.TokensPileView(model: @_tokenModel('credit')))

  _renderTagsOrBadPub: ->
    if @model.get('type') == 'corp'
      @tagsAndBadPub.show(new Monolith.Views.TokensPileView(model: @_tokenModel('bad-publicity')))
    else
      @tagsAndBadPub.show(new Monolith.Views.TokensPileView(model: @_tokenModel('tag')))

  _tokenModel: (type) ->
    @model.get('tokens').ofType(type)