class Monolith.Input

  @isMouseDown = false

$(window).mousedown -> Monolith.Input.isMouseDown = true
$(window).mouseup   -> Monolith.Input.isMouseDown = false
$(window).click     -> Monolith.Input.isMouseDown = false