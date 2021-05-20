extends WAT.Test 

var Scene = preload("res://scenes/field_scene.tscn")
var scene = null

func pre():
	scene = Scene.instance()
	scene._ready()


func test_can_create_scene() -> void:
	asserts.is_not_null(scene)


func test_has_a_tile_map() -> void:
	asserts.is_not_null(scene.tilemap)


func test_has_a_field() -> void:
	asserts.is_not_null(scene.field)


#func test_setting_a_player_in_the_player_array_updates_tile_map() -> void:
#	var player = Player.new()
#	scene.field.set_player(player, Vector2(3,2))

#func test_can_set_a_player_clicking_on_the_tilmap() -> void:
#	var player = Player.new()
#	scene.selected_player  = player
#	scene.status = GameState.PLAYER_PLACEMENT
#


