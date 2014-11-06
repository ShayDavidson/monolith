class Monolith.Views.MarkdownView extends Marionette.ItemView
  el: '.markdown-editor'
  template: false

  ui:
    overlay: '.markdown-overlay'
    button: '.markdown-btn'
    input: "#input"
    updateBtn: '.update-btn'

  events:
    'click @ui.button': 'showOverlay'
#    'change @ui.input': 'updateModel'
    'keyup @ui.input': 'onkeyup'
    'click @ui.updateBtn': 'updateModel'


  showOverlay: ->
    @ui.overlay.show()

  initialize: ->
    @bindUIElements()

  updateModel: ->
    console.log('update model', @ui.input.val())
    @model.set('text', @ui.input.val())
    @model.translate()
    @ui.overlay.hide()

#  onRender: ->
#    @ui.output.val(JSON.stringify(@model.toJSON(), undefined, 2))

  onkeyup: ->
    text = @ui.input.val()
    game = Monolith.Markdown.MarkdownParser.parse(text)
    @model.set(game.attributes)
    @render()
