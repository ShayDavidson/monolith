class Monolith.Views.RowView extends Backbone.Marionette.CollectionView
  className: 'row'
  childView: Monolith.Views.CardView

  ROW_CARD_OFFSET = 0.3
  BASE_WINDOW_HEIGHT = 750

  initialize: ->
    $(window).resize(=> @_setRowCardOffset())

  onShow: ->
    @_setRowCardOffset()

  _setRowCardOffset: ->
    side = @options.side
    @children.each((cardView, index) ->
      heightRatio = $(window).height() / BASE_WINDOW_HEIGHT
      offset = "#{index * ROW_CARD_OFFSET * heightRatio}px"
      cardView.$el.css('margin-top': offset)
      if side == 'left'
        cardView.$el.css('margin-left': offset)
      else
        cardView.$el.css('margin-right': offset)
    )

class Monolith.Views.RowCollectionView extends Backbone.Marionette.CollectionView
  className: 'rows'
  childView: Monolith.Views.RowView
  childViewOptions: (row) ->
    collection: row.get('cardPiles')
    side: @options.side

  BASE_ROW_Z_INDEX = 2000

  onRender: ->
    count = @children.length
    @children.each((rowView, index) ->
      rowView.$el.css('z-index': BASE_ROW_Z_INDEX + count - index)
    )