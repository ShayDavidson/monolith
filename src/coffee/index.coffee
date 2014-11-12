window.Monolith = new Backbone.Marionette.Application()

Monolith.Models = {}
Monolith.ViewModels = {}
Monolith.Views = {}
Monolith.Services = {}
Monolith.Markdown = {}

$ ->
  Monolith.addRegions
    currentRegion: '.current-region'
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'
    zoomedCardRegion: '.zoomed-card-container'

  # Editor
  markdown = new Monolith.Models.Markdown()
  window.markdown = markdown
  markdownView = new Monolith.Views.MarkdownView(model: markdown)

  gameViewModel = Monolith.ViewModels.GameViewModel.defaultGame()
  markdown.set('viewModel', gameViewModel)

  runnerView = new Monolith.Views.PlayerView(model: gameViewModel.get('runner'))
  corpView = new Monolith.Views.PlayerView(model: gameViewModel.get('corp'))
  currentView = new Monolith.Views.CardView(model: gameViewModel.get('current'))
  Monolith.currentRegion.show(currentView)

  if gameViewModel.isRunnerOnLeft()
    Monolith.leftPlayRegion.show(runnerView)
    Monolith.rightPlayRegion.show(corpView)
  else
    Monolith.rightPlayRegion.show(runnerView)
    Monolith.leftPlayRegion.show(corpView)

  markdownView.on('updated', () ->
    if (card = gameViewModel.get('current'))
      currentView = new Monolith.Views.CardView(model: card)
      Monolith.currentRegion.show(currentView)
    else
      Monolith.currentRegion.empty()

    runnerView.render()
    corpView.render()
    $(window).trigger('resize')
  )


  # Events

  $(window).trigger('resize') # fixes some issues with card sizes.
