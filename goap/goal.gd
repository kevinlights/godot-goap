#
# Goal contract
#
extends Node

# 目标基类，用于子类继承和覆盖
class_name GoapGoal


#
# This indicates if the goal should be considered or not.
# Sometimes instead of changing the priority, it is easier to
# not even consider the goal. i.e. Ignore combat related goals
# when there are not enemies nearby.
#
func is_valid(actor) -> bool:
	return true

#
# Returns goals priority. This priority can be dynamic. Check
# `./goals/keep_fed.gd` for an example of dynamic priority.
#
func priority(actor) -> int:
	return 1

#
# Plan's desired state. This is usually referred as desired world
# state, but it doesn't need to match the raw world state.
#
# For example, in your world state you may store "hunger" as a number, but inside your
# goap you can deal with it as "is_hungry".
func get_desired_state(actor) -> Dictionary:
	return {}
