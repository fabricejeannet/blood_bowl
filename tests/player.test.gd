extends WAT.Test 

var Player = load("res://scripts/player.gd")
var player = null

func pre():
	player = Player.new(0, 1) 


func test_can_create_a_player() -> void:
	asserts.is_not_null(player)


func test_players_default_state_is_idle() -> void:
	asserts.is_equal(player.get_status(), PlayerStatus.IDLE)
	
