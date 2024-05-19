extends StaticBody2D

@export var nutrition = 30
@onready var animation_player = $AnimationPlayer



func _ready():
	animation_player.play("spawn")
