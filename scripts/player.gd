class_name Player

var status = null
var idle_texture:int
var playing_texture:int

func _init(_idle_texture, _playing_texture):
	status = PlayerStatus.IDLE
	idle_texture = _idle_texture
	playing_texture = _playing_texture


func get_status():
	return status
