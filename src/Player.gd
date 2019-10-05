extends Node2D

var targetPos = position
var speed = 150

var id

# Called when the node enters the scene tree for the first time.
func _init(pos = position):
  set_position(pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  updatePosition(delta)

func updatePosition(delta):
  if position.x != targetPos.x or position.y != targetPos.y:
    var distance2 = position.distance_squared_to(targetPos)
    if distance2 > 1:
      var dir = position.direction_to(targetPos);
      position.x += dir.x * delta * speed
      position.y += dir.y * delta * speed
    else:
      set_position(targetPos)

