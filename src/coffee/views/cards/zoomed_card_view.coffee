class Monolith.Views.ZoomedCardView extends Monolith.Views.BaseCardView

  ZOOM_FADE_DURATION = 250

  onBeforeShow: ->
    @$el.addClass('hidden')

  onShow: ->
    setTimeout((=> @$el.removeClass('hidden')), 50)

  hide: ->
    @$el.addClass('hidden')
    setTimeout((=> @destroy()), ZOOM_FADE_DURATION)
