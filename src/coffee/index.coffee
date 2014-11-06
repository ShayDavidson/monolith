window.Monolith = new Backbone.Marionette.Application()

Monolith.Models = {}
Monolith.ViewModels = {}
Monolith.Views = {}
Monolith.Services = {}
Monolith.Markdown = {}

$ ->
#  window.game = game
#  markdownView = new Monolith.Views.MarkdownView(model: game)

  # Regions

  Monolith.addRegions
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'
    zoomedCardRegion: '.zoomed-card-container'

  # Editor
  markdown = new Monolith.Models.Markdown()
  markdownView = new Monolith.Views.MarkdownView(model: markdown)

  gameViewModel = Monolith.ViewModels.GameViewModel.defaultGame()
  markdown.set('viewModel', gameViewModel)

  runnerView = new Monolith.Views.PlayerView(model: gameViewModel.get('runner'))
  corpView = new Monolith.Views.PlayerView(model: gameViewModel.get('corp'))

  if gameViewModel.isRunnerOnLeft()
    Monolith.leftPlayRegion.show(runnerView)
    Monolith.rightPlayRegion.show(corpView)
  else
    Monolith.rightPlayRegion.show(runnerView)
    Monolith.leftPlayRegion.show(corpView)

  # Events

  $(window).trigger('resize') # fixes some issues with card sizes.