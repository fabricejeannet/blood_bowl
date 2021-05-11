class_name Field

var _player_array = []
var _tackle_array = []

const WIDTH = 15
const HEIGHT = 26

func _init():
	for _x in WIDTH:
		var col =  []
		col.resize(HEIGHT)
		_player_array.append(col)			
		
	_tackle_array = _player_array.duplicate(true)
	fill(_tackle_array, 0)


func fill(array, value) -> void:	
	for x in WIDTH:
		for y in HEIGHT:
			array[x][y] = value


func get_player_array():
	return _player_array


func get_player(position):
	return _player_array[position.x][position.y]


func set_player(player, position):
	_player_array[position.x][position.y] = player
	_update_surrounding_positions(position)


func _update_surrounding_positions(position) -> void:
	var surrounding_positions = get_surrounding_positions(position)
	for sp in surrounding_positions:
		_tackle_array[sp.x][sp.y] += 1
	

func get_tackle_array():
	return _tackle_array


func get_surrounding_positions(position):
	var positions = []
	for x in range(position.x-1, position.x+2):
		for y in range(position.y-1, position.y+2):
			var surrounding_position = Vector2(x, y)
			if position != surrounding_position and is_inside_the_field(surrounding_position):
				positions.append(surrounding_position)
#				print(surrounding_position)
	return positions


func is_inside_the_field(position) -> bool:
	return position.x >= 0 and position.x < WIDTH and position.y >= 0 and position.y < HEIGHT


func remove_player(position:Vector2) -> void:
	_player_array[position.x][position.y] = null
		
	
