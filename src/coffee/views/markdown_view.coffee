class Monolith.Views.MarkdownView extends Marionette.ItemView
  el: '.markdown-editor'
  template: false

  ui:
    overlay: '.markdown-overlay'
    button: '.markdown-btn'
    input: "#input"

  events:
    'click @ui.button': 'showOverlay'
#    'change @ui.input': 'updateModel'
    'keyup @ui.input': 'updateModel'


  showOverlay: ->
    @ui.overlay.show()

  initialize: ->
    @bindUIElements()



#  onRender: ->
#    @ui.output.val(JSON.stringify(@model.toJSON(), undefined, 2))

  updateModel: ->
    text = @ui.input.val()
    game = Monolith.Markdown.MarkdownParser.parse(text)
    @model.set(game.attributes)
    @render()
