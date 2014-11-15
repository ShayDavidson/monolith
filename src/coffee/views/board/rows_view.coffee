class Monolith.Views.RowView extends Backbone.Marionette.CollectionView
  className: 'row'
  childView: Monolith.Views.CardPileView
  childViewOptions: (row) ->
    collection: row.get('cards')
    side: @options.side

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