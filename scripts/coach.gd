class_name Coach

var _attempt_count = 0

const MAX_ATTEMPT_COUNT = 8

func get_attempt_count() -> int:
	return _attempt_count


func increment_attempt_count() -> void:
	_attempt_count += 1


func has_completed_his_attempts() -> bool:
	return _attempt_count == MAX_ATTEMPT_COUNT
