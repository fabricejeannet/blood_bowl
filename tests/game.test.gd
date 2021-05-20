extends WAT.Test

var Game = preload("res://scenes/game.tscn")
var game = null
var coach1 = null
var coach2 = null

func pre():
	game = Game.instance()
	game._ready()
	
	coach1 = Coach.new()
	coach2 = Coach.new()	


func test_can_create_game() -> void:
	asserts.is_not_null(game)


func test_game_has_a_15x26_field() -> void:
	var field = game.get_field()
	asserts.is_not_null(field)
	asserts.is_equal(field.WIDTH,  15)
	asserts.is_equal(field.HEIGHT, 26)


func test_can_set_two_coaches() -> void:
	game.set_coaches(coach1, coach2)
	asserts.is_true(game.coaches_are_set())


func test_both_coaches_must_be_set() -> void:
	var coach = Coach.new()
	game.set_coaches(coach, null)
	asserts.is_false(game.coaches_are_set())
	game.set_coaches(null, coach)
	asserts.is_false(game.coaches_are_set())
	game.set_coaches(null, null)
	asserts.is_false(game.coaches_are_set())


func test_there_has_to_be_two_different_coaches() -> void:
	var coach = Coach.new()
	game.set_coaches(coach, coach)
	asserts.is_false(game.coaches_are_set())


func test_game_starts_at_the_first_half_time() -> void:
	asserts.is_true(game.is_in_the_first_half_time())
	asserts.is_false(game.is_in_the_second_half_time())

func test_cannot_go_to_the_second_halftime_until_both_coaches_has_completed_all_their_attempts() -> void:
	game.set_coaches(coach1, coach2)
	asserts.is_false(game.next_half_time())
	coach1._attempt_count = 8
	game.set_coaches(coach1, coach2)
	asserts.is_false(game.next_half_time())
	coach2._attempt_count = 8
	game.set_coaches(coach1, coach2)
	asserts.is_true(game.next_half_time())

#func test_game_has_a_field_scene() -> void:
#	asserts.is_not_null(game.field_scene)
