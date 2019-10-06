extends Node2D

var targetPos = position
var speed = 150

var id

# Called when the node enters the scene tree for the first time.
func _init(pos = position):
  set_position(pos)
  targetPos = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  updatePosition(delta)

func updatePosition(delta):
  if position.x != targetPos.x or position.y != targetPos.y:
    var distance2 = position.distance_squared_to(targetPos)
    if distance2 > pow(delta * speed, 2):
      var dir = position.direction_to(targetPos);
      position.x += dir.x * delta * speed
      position.y += dir.y * delta * speed
    else:
      set_position(targetPos)

func setAction(action):
    # Mouse buttons might be 1, 2, 3, 4, 5, 8, 9
    if action > 5:
        action -= 2
    $Sprite.modulate = Color((action & 4) >> 2, (action & 2) >> 1, action & 1)