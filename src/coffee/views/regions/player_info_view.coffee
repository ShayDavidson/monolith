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
    @credits.show(new Monolith.Views.TokensPileView(type: 'credit', amount: @model.get('credits')))

  _renderTagsOrBadPub: ->
    if @model.get('type') == 'corp'
      @tagsAndBadPub.show(new Monolith.Views.TokensPileView(type: 'bad-publicity', amount: @model.get('badPublicity')))
    else
      @tagsAndBadPub.show(new Monolith.Views.TokensPileView(type: 'tag', amount: @model.get('tags')))