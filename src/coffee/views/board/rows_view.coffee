class Monolith.Views.RowView extends Backbone.Marionette.CollectionView
  className: 'row'
  childView: Monolith.Views.PileView
  childViewOptions: (row) ->
    collection: row.get('cards')
    side: @options.side

  BASE_PILE_Z_INDEX = 3000

  onRender: ->
    count = @children.length
    @children.each((pileView, index) ->
      pileView.$el.css('z-index': BASE_PILE_Z_INDEX + count - index)
    )

class Monolith.Views.RowCollectionView extends Backbone.Marionette.CollectionView
  className: 'rows'
  childView: Monolith.Views.RowView
  childViewOptions: (row) ->
    collection: row.get('piles')
    side: @options.side

  BASE_ROW_Z_INDEX = 2000

  onRender: ->
    count = @children.length
    @children.each((rowView, index) ->
      rowView.$el.css('z-index': BASE_ROW_Z_INDEX + count - index)
    )