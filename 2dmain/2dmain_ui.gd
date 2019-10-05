extends Node

onready var _client = get_node("WSClient")
onready var _host = get_node("LineEdit")
onready var Player = preload("res://src/Player.tscn")

func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
    if event is InputEventMouseButton:
        if event.pressed:
            print("button was clicked at ", event.position , event.button_index)            
            
            if event.button_index == BUTTON_MIDDLE:
              instantiatePlayer(event.position)
            if event.button_index == BUTTON_RIGHT:
              randomizePlayerTargets()
            
            var buf = StreamPeerBuffer.new()
            var x = event.position.x
            var y = event.position.y
            buf.put_8(Parser.TYPE.action)
            buf.put_16(x)
            buf.put_16(y)
            buf.put_8(event.button_index)
            print("button was clicked at ", x, " ", y, " ", event.button_index)
            _client.send_raw_data(buf.data_array)
    if event is InputEventMouseMotion:
            var buf = StreamPeerBuffer.new()
            var x = event.position.x
            var y = event.position.y
            buf.put_8(Parser.TYPE.location)
            buf.put_16(x)
            buf.put_16(y)
            _client.send_raw_data(buf.data_array)


func instantiatePlayer(pos):
  var p = Player.instance()
  p._init(pos)
  get_node("Players").add_child(p)
  
func randomizePlayerTargets():
  var players = get_node("Players");
  for i in range(0, players.get_child_count()):
    var newPos = Vector2(rand_range(0, 600), rand_range(0, 360))
    var player = players.get_child(i);
    ##var script = player.get_script()
    player.targetPos = newPos;

func _on_Button_toggled(button_pressed):
    if button_pressed:
        if _host.text != "":
            print("Connecting to host: %s" % [_host.text])
            var supported_protocols = PoolStringArray(["my-protocol2", "my-protocol", "binary"])
            _client.connect_to_url(_host.text, supported_protocols, false)
    else:
        _client.disconnect_from_host()
