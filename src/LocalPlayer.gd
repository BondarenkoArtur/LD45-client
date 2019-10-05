extends "res://src/Player.gd"



func _input(event):
  if event is InputEventMouseButton:
    if event.pressed and event.button_index == BUTTON_LEFT:
      targetPos = event.position
