class Monolith.Views.MarkdownView extends Marionette.ItemView
  el: '.markdown-editor'
  template: false

  ui:
    backlayer: '.markdown-backlayer'
    overlay: '.markdown-overlay'
    button: '.markdown-btn'
    input: "#input"

  events:
    'click @ui.button': 'showOverlay'
    'keydown @ui.input': 'onkeydown'
    'keyup @ui.input': 'onkeyup'
    'click @ui.backlayer': 'updateModel'
    'click @ui.overlay': (ev) -> ev.stopPropagation()

  showOverlay: ->
    @ui.backlayer.show()
    @ui.input.val(@model.get('text'))

  initialize: ->
    @bindUIElements()

  updateModel: ->
    @model.set('text', @ui.input.val())
    @model.translate()
    @ui.backlayer.hide()
    @trigger('updated')

  onkeyup: ->
    text = @ui.input.val()
    game = Monolith.Markdown.MarkdownParser.parse(text)
    @model.set(game.attributes)
    @render()

  onkeydown: (ev)->
    if (ev.keyCode == 9) # tab was pressed
      ev.preventDefault()
      startingCaretPosition = @ui.input.get(0).selectionStart
      newCaretPosition = startingCaretPosition + "\t".length
      @ui.input.val(@ui.input.val().substring(0, startingCaretPosition) + "\t" + @ui.input.val().substring(startingCaretPosition, @ui.input.val().length))
      @ui.input.get(0).selectionStart = newCaretPosition
      @ui.input.get(0).selectionEnd = newCaretPosition