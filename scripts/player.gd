class_name Player

var status = null

export(Texture) var idle_texture
export(Texture) var playing_texture

func _init():
	status = PlayerStatus.IDLE
	
func get_status():
	return status
