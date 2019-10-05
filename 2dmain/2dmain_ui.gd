extends Node

onready var _client = get_node("WSClient")
onready var _host = get_node("LineEdit")


func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_toggled(button_pressed):
	if button_pressed:
		if _host.text != "":
			print("Connecting to host: %s" % [_host.text])
			var supported_protocols = PoolStringArray(["my-protocol2", "my-protocol", "binary"])
			_client.connect_to_url(_host.text, supported_protocols, false)
	else:
		_client.disconnect_from_host()


func _on_Button_pressed():
	print("ASDASDA")

