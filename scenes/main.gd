extends Node2D


@onready var _hunger_field = $HUD/VBoxContainer/MarginContainer/HBoxContainer/hunger
var mushroom_scn = preload("res://scenes/mushroom.tscn")

var gameTime = 0

func _on_hanger_timer_timeout():
	_hunger_field.value = WorldState.get_state("hunger", 0)
	if _hunger_field.value < 100:
		_hunger_field.value += 2

	WorldState.set_state("hunger", _hunger_field.value)


func _on_reload_pressed():
	WorldState.clear_state()
	# warning-ignore:return_value_discarded
	self.get_tree().reload_current_scene()


func _on_pause_pressed():
	get_tree().paused = not get_tree().paused
	$HUD/VBoxContainer/MarginContainer/HBoxContainer/pause.text = (
		"Resume" if get_tree().paused else "Pause"
	)


func _on_console_pressed():
	var console = get_tree().get_nodes_in_group("console")[0]
	console.visible = not console.visible
	$HUD/VBoxContainer/MarginContainer/HBoxContainer/console.text = (
		"Hide Console" if console.visible else "Show Console"
	)


func _on_game_timer_timeout():
	gameTime += 1
	$HUD/VBoxContainer/MarginContainer/HBoxContainer/game_time.text = str(gameTime)
	# 每隔 10 秒自动随机生成 mushroom
	if gameTime % 10 == 0:
		gen_mushroom()

func gen_mushroom():
	var mushroom = mushroom_scn.instantiate()
	randomize()
	var pos = Vector2(randi() % 445 + 5, randi() % 245 + 5) # [5,5] -> [450,250]
	mushroom.position = pos
	mushroom.add_to_group("food")
	WorldState.console_message({"msg": "gen mushroom", "pos": pos})
	add_child(mushroom)
