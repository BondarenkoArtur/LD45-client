extends Node

onready var _client = get_node("WSClient")
onready var _host = get_node("LineEdit")

func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
    if event is InputEventMouseButton:
        if event.pressed:
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

func _on_Button_toggled(button_pressed):
    if button_pressed:
        if _host.text != "":
            print("Connecting to host: %s" % [_host.text])
            var supported_protocols = PoolStringArray(["my-protocol2", "my-protocol", "binary"])
            _client.connect_to_url(_host.text, supported_protocols, false)
    else:
        _client.disconnect_from_host()
