class Monolith.Views.PlayerInfoView extends Backbone.Marionette.LayoutView
  template: '#player-info-view-template'
  className: 'player-info'

  regions:
    credits: '.credits-region'
    tagsAndBadPub: '.tags-bp-region'
    brainDmg: '.brain-dmg-region'

  onRender: ->
    @_renderCredits()
    @_renderTagsOrBadPub()
    @_renderBrainDamage()

  _renderCredits: ->
    @credits.show(new Monolith.Views.TokensPileView(model: @_tokenModel('credit')))

  _renderTagsOrBadPub: ->
    if @model.get('type') == 'corp'
      @tagsAndBadPub.show(new Monolith.Views.TokensPileView(model: @_tokenModel('bad-publicity')))
    else
      @tagsAndBadPub.show(new Monolith.Views.TokensPileView(model: @_tokenModel('tag')))

  _renderBrainDamage: ->
    @brainDmg.show(new Monolith.Views.TokensPileView(model: @_tokenModel('brain-damage')))

  _tokenModel: (type) ->
    @model.get('tokens')?.ofType(type)