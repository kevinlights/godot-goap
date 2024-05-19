extends GoapGoal

class_name CalmDownGoal

func get_clazz(): return "CalmDownGoal"

func is_valid(actor) -> bool:
	# return WorldState.get_state("is_frightened", false)
	return actor.get_state("is_frightened", false)


func priority(actor) -> int:
	return 10


func get_desired_state(actor) -> Dictionary:
	return {
		"is_frightened": false
	}
