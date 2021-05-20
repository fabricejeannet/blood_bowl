extends TileMap


func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			print("mouse : ", get_global_mouse_position())
			print("case : ", self.world_to_map(get_global_mouse_position()))
