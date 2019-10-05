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
        print("TYPE: Location")
        while (buf.get_available_bytes() > 0):
            print("X: ", buf.get_16(), " Y: ", buf.get_16())
    elif msg_type == TYPE.action:
        print("TYPE: Action")
        while (buf.get_available_bytes() > 0):
            print("X: ", buf.get_16(), " Y: ", buf.get_16(), " Btn: ", buf.get_8())
    elif msg_type == TYPE.identification:
        print("TYPE: Identification")
        client_id = buf.get_8()
        print("Your id: ", client_id)
        