extends Node

enum TYPE {
    location = 1,
    action = 2,
    identification = 3
}

var client_id = 0

func process_resp(resp):
    var buf = StreamPeerBuffer.new()
    buf.data_array = resp
    var msg_type = buf.get_8()
    if msg_type == TYPE.location:
        var dict = Dictionary()
        print("TYPE: Location")
        while (buf.get_available_bytes() > 0):
            dict[get_user_id(buf)] = Vector2(buf.get_16(), buf.get_16())
        update_user_coordinates(dict)
    elif msg_type == TYPE.action:
        var dict = Dictionary()
        var dict_btn = Dictionary()
        print("TYPE: Action")
        while (buf.get_available_bytes() > 0):
            var user_id = get_user_id(buf)
            dict[user_id] = Vector2(buf.get_16(), buf.get_16())
            dict_btn[user_id] = buf.get_8()      
        update_user_coordinates(dict)
        update_user_action(dict_btn)
    elif msg_type == TYPE.identification:
        print("TYPE: Identification")
        client_id = get_user_id(buf)
        print("Your id: ", client_id)
        
func update_user_coordinates(dict):
    var parent = get_parent()    
    var players = parent.get_node("Players")
    for key in dict.keys():
        var player = players.get_node_or_null(str(key))
        if player == null:
            parent.instantiatePlayer(dict[key], key)
        else:
            player.targetPos = dict[key]

func update_user_action(dict):
    var parent = get_parent()    
    var players = parent.get_node("Players")
    for key in dict.keys():
        var player = players.get_node_or_null(str(key))
        if player != null:
            player.setAction(dict[key])


func get_user_id(buf):
    return buf.get_16()
