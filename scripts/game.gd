class_name Game

var _field:Field
var _coach1:Coach
var _coach2:Coach
var _current_haltime 

const FIRST_HALFTIME = 0
const SECOND_HALFTIME = 1


func _init():
	_field = Field.new()
	_current_haltime = FIRST_HALFTIME

func get_field() -> Field:
	return _field

func set_coaches (coach1, coach2) -> void:
	_coach1 = coach1
	_coach2 = coach2

func coaches_are_set() -> bool:
	return _coach1 != null and _coach2 != null and _coach1 != _coach2

func is_in_the_first_half_time() -> bool:
	return _current_haltime == FIRST_HALFTIME

func is_in_the_second_half_time() -> bool:
	return _current_haltime == SECOND_HALFTIME


func next_half_time() -> bool:
	if _coach1.has_completed_his_attempts() and _coach2.has_completed_his_attempts():
		_current_haltime = SECOND_HALFTIME
		return true
	else:
		return false
