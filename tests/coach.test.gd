extends WAT.Test

var Coach = load("res://scripts/coach.gd")
var coach = null


func pre():
	coach = Coach.new()


func test_can_create_coach() -> void:
	asserts.is_not_null(coach)


func test_coach_starts_with_zero_attempts() -> void:
	asserts.is_equal(coach.get_attempt_count(), 0)


func test_can_increment_attempt_count() -> void:
	coach.increment_attempt_count()
	asserts.is_equal(coach.get_attempt_count(), 1)
	
