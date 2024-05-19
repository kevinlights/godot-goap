extends GoapGoal

class_name KeepFirepitBurningGoal

func get_clazz(): return "KeepFirepitBurningGoal"


func is_valid(actor) -> bool:
	return WorldState.get_elements("firepit").size() == 0


func priority(actor) -> int:
	return 1


func get_desired_state(actor) -> Dictionary:
	return {
		"has_firepit": true
	}
