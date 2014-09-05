window.App = new Backbone.Marionette.Application()

App.Models = {}
App.Views = {}

$ ->
  App.addRegions
    leftPlayRegion: '.play-region.left'
    rightPlayRegion: '.play-region.right'

  runnerModel = new App.Models.PlayerModel(side: 'runner')
  corpModel = new App.Models.PlayerModel(side: 'corp')

  runnerView = new App.Views.PlayerView(model: runnerModel)
  corpView = new App.Views.PlayerView(model: corpModel)

  App.leftPlayRegion.show(runnerView)
  App.rightPlayRegion.show(corpView)
