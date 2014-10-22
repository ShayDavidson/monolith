class App.Views.ZoomedCardView extends App.Views.BaseCardView

  ZOOM_FADE_DURATION = 250

  onBeforeShow: ->
    @$el.addClass('hidden')

  onShow: ->
    setTimeout((=> @$el.removeClass('hidden')), 10)

  hide: ->
    @$el.addClass('hidden')
    setTimeout((=> @destroy()), ZOOM_FADE_DURATION)
