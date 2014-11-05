class Monolith.Models.Markdown extends Backbone.Model
  defaults:
    text: ''
    game: null
    viewModel: null

  translate: ->
    game = Monolith.Markdown.MarkdownParser.parse(@get('text'))
    @set('game', game)
#    viewModel.