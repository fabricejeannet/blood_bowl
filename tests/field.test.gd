extends WAT.Test 

var Field = preload("res://scenes/field.tscn")
var field = null

func pre():
	field = Field.instance()
	field._ready()

func test_can_create_field() -> void:
	asserts.is_not_null(field)


func test_has_a_tile_map() -> void:
	asserts.is_not_null(field.field_tiles)

func test_has_a_special_tiles_map() -> void:
	asserts.is_not_null(field.special_tiles)

func test_player_array_starts_empty() -> void:
	var is_empty = true
	for x in field.WIDTH:
		for y in field.HEIGHT:
			is_empty = is_empty and field.get_player(Vector2(x,y)) == null	
	asserts.is_equal(true, is_empty)	


func test_tackle_array_starts_empty() -> void:
	var tackle_array = field.get_tackle_array()
	var sum = 0
	for x in field.WIDTH:
		for y in field.HEIGHT:
			sum += tackle_array[x][y]
	asserts.is_equal(sum, 0)


func test_can_set_player() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(4, 3)
	field.set_player(player, position)
	asserts.is_equal(field.get_player(position), player)


func test_surrounding_positions_in_a_general_position() -> void:
	var surrounding_positions = field.get_surrounding_positions(Vector2(3, 4))
	asserts.is_equal(surrounding_positions.size(), 8)
	asserts.is_equal(surrounding_positions.count(Vector2(2, 3)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(3, 3)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(4, 3)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(2, 4)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(4, 4)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(2, 5)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(3, 5)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(4, 5)), 1)


func test_surrounding_positions_in_top_left_corner() -> void:
	var surrounding_positions = field.get_surrounding_positions(Vector2(0, 0))
	asserts.is_equal(surrounding_positions.size(), 3)
	asserts.is_equal(surrounding_positions.count(Vector2(1, 0)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(0, 1)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(1, 1)), 1)


func test_surrounding_positions_in_bottom_left_corner() -> void:
	var surrounding_positions = field.get_surrounding_positions(Vector2(0, field.HEIGHT - 1))
	asserts.is_equal(surrounding_positions.size(), 3)
	asserts.is_equal(surrounding_positions.count(Vector2(1, field.HEIGHT - 1)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(0, field.HEIGHT - 2)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(1, field.HEIGHT - 2)), 1)


func test_surrounding_positions_in_bottom_right_corner() -> void:
	var surrounding_positions = field.get_surrounding_positions(Vector2(field.WIDTH - 1, field.HEIGHT - 1))
	asserts.is_equal(surrounding_positions.size(), 3)
	asserts.is_equal(surrounding_positions.count(Vector2(field.WIDTH - 2, field.HEIGHT - 1)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(field.WIDTH - 2, field.HEIGHT - 2)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(field.WIDTH - 1, field.HEIGHT - 2)), 1)


func test_surrounding_positions_in_top_right_corner() -> void:
	var surrounding_positions = field.get_surrounding_positions(Vector2(field.WIDTH - 1, 0))
	asserts.is_equal(surrounding_positions.size(), 3)
	asserts.is_equal(surrounding_positions.count(Vector2(field.WIDTH - 2, 0)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(field.WIDTH - 2, 1)), 1)
	asserts.is_equal(surrounding_positions.count(Vector2(field.WIDTH - 1, 1)), 1)


func test_setting_a_player_updates_the_tackle_array() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(0, 0)
	field.set_player(player, position)
	var tackle_array = field.get_tackle_array()
	asserts.is_equal(1, tackle_array[1][0])
	asserts.is_equal(1, tackle_array[1][1])
	asserts.is_equal(1, tackle_array[0][1])


func test_can_remove_a_player_from_the_player_array() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(5, 6)
	field.set_player(player, position)
	field.remove_player(position)
	asserts.is_null(field.get_player(position))


func test_can_removing_a_player_updates_tackle_array() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(5, 6)
	field.set_player(player, position)
	field.remove_player(position)
	var surrounding_positions = field.get_surrounding_positions(position)
	var sum = 0
	var tackle_array = field.get_tackle_array()
	for sp in surrounding_positions:
		sum += tackle_array[sp.x][sp.y]
	asserts.is_equal(sum, 0)
	
func test_clicking_on_a_player_displays_its_tackle_area() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(0, 0)
	field.set_player(player, position)
	
	asserts.is_not_equal(field.special_tiles.get_cellv(Vector2(1,0)), 0)
	asserts.is_not_equal(field.special_tiles.get_cellv(Vector2(1,1)), 0)
	asserts.is_not_equal(field.special_tiles.get_cellv(Vector2(0,1)), 0)
	
	field.tile_clicked(position)
	
	asserts.is_equal(field.special_tiles.get_cellv(Vector2(1,0)), 0)
	asserts.is_equal(field.special_tiles.get_cellv(Vector2(1,1)), 0)
	asserts.is_equal(field.special_tiles.get_cellv(Vector2(0,1)), 0)

func test_can_select_a_player_clicking_on_his_tile() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(0, 0)
	field.set_player(player, position)
	field.tile_clicked(position)
	asserts.is_equal(field.get_selected_player(), player)


func test_the_idle_texture_is_displayed_when_a_player_is_not_selected() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(0, 0)
	field.set_player(player, position)
	asserts.is_equal(field.player_tiles.get_cellv(position), 0)


func test_the_playing_texture_is_displayed_when_a_player_is_selected() -> void:
	var player = Player.new(0, 1)
	var position = Vector2(0, 0)
	field.set_player(player, position)
	field.tile_clicked(position)
	asserts.is_equal(field.player_tiles.get_cellv(position), 0)
