class Monolith.Input

  @isMouseDown = false

$('body').mousedown -> Monolith.Input.isMouseDown = true
$('body').mouseup   -> Monolith.Input.isMouseDown = false