extends Node2D


@onready var _hunger_field = $HUD/VBoxContainer/MarginContainer/HBoxContainer/hunger
var mushroom_scn = preload("res://scenes/mushroom.tscn")
var tree_scn = preload("res://scenes/tree.tscn")

var gameTime = 0
var players = []

func _ready():
	for node in get_tree().get_nodes_in_group("player"):
		players.append(node)
	print("player size: ", players.size())

func _on_hanger_timer_timeout():
	for p in players:
		var v = p.get_state("hunger", 0)
		if v < 100:
			v += 2
		p.set_state("hunger", v)
	
	#_hunger_field.value = WorldState.get_state("hunger", 0)
	#if _hunger_field.value < 100:
		#_hunger_field.value += 2
#
	#WorldState.set_state("hunger", _hunger_field.value)


func _on_reload_pressed():
	for p in players:
		p.clear_state()
	#WorldState.clear_state()
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
	# 每隔 100 秒生成 tree
	if gameTime % 100 == 0:
		gen_tree()


func gen_mushroom():
	var mushroom = mushroom_scn.instantiate()
	var pos = WorldState.get_rand_pos()
	mushroom.position = pos
	mushroom.add_to_group("food")
	print({"msg": "gen mushroom", "pos": pos})
	WorldState.console_message({"msg": "gen mushroom", "pos": pos})
	add_child(mushroom)


func gen_tree():
	var tree = tree_scn.instantiate()
	var pos = WorldState.get_rand_pos()
	tree.position = pos
	tree.add_to_group("tree")
	print({"msg": "gen tree", "pos": pos})
	WorldState.console_message({"msg": "gen tree", "pos": pos})
	add_child(tree)
